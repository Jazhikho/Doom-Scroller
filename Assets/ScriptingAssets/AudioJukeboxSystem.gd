class_name AudioJukeboxSystem
extends Node

## Reusable random jukebox.
## Call [method configure] once, then [method start_with_tracks].
## Use this for non-gameplay-critical background music or ambient playlists.
## This system owns its internal [AudioStreamPlayer].
## Assumes the target audio bus exists.
## Do not use this for timing-critical cue sync unless you add explicit cue controls.
## Default process mode is ALWAYS so playback continues during tree pause unless configured otherwise.

var _player: AudioStreamPlayer
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _tracks: Array[AudioStream] = []
var _last_index: int = -1
var _remaining_indices: Array[int] = []
var _play_sequence: int = 0
var _shuffle_enabled := true
var _track_delay_seconds := 0.0
var _delay_timer: Timer


## Configures underlying player.
## Parameters:
##   bus_name: Audio bus to route to.
##   volume_db: Starting volume.
func configure(bus_name: StringName = &"Music", volume_db: float = 0.0, target_process_mode: ProcessMode = Node.PROCESS_MODE_ALWAYS) -> void:
	if _player == null:
		_player = AudioStreamPlayer.new()
		add_child(_player)
		_player.finished.connect(_on_track_finished)
	if _delay_timer == null:
		_delay_timer = Timer.new()
		_delay_timer.one_shot = true
		add_child(_delay_timer)
		_delay_timer.timeout.connect(_play_next_random)
	_player.process_mode = target_process_mode
	_delay_timer.process_mode = target_process_mode
	_rng.randomize()
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	if bus_index < 0:
		push_warning("AudioJukeboxSystem: missing audio bus " + str(bus_name) + "; falling back to Master.")
		_player.bus = &"Master"
	else:
		_player.bus = bus_name
	_player.volume_db = volume_db


## Starts playback from an array of streams.
## Non-audio entries are ignored.
func start_with_tracks(streams: Array, shuffle_enabled: bool = true, delay_seconds: float = 0.0, start_index: int = -1) -> void:
	if _player == null:
		configure()
	_play_sequence += 1
	var sequence: int = _play_sequence
	_shuffle_enabled = shuffle_enabled
	_track_delay_seconds = maxf(0.0, delay_seconds)
	if _delay_timer != null:
		_delay_timer.stop()
	_tracks.clear()
	_remaining_indices.clear()
	var i: int = 0
	while i < streams.size():
		var entry: Variant = streams[i]
		if entry is AudioStream:
			_tracks.append(entry as AudioStream)
		i += 1
	if _tracks.size() == 0:
		push_warning("AudioJukeboxSystem: no playable tracks.")
		return
	_refill_shuffle_bag()
	call_deferred("_play_deferred", sequence, start_index)


## Stops playback and clears playlist.
func stop() -> void:
	_play_sequence += 1
	if _player != null:
		_player.stop()
		_player.stream = null
		_player.volume_db = 0.0
	if _delay_timer != null:
		_delay_timer.stop()
	_tracks.clear()
	_remaining_indices.clear()
	_last_index = -1


func play_index(index: int) -> void:
	if _tracks.is_empty():
		return
	_play_sequence += 1
	_play_track_at(clampi(index, 0, _tracks.size() - 1))


func play_next() -> void:
	if _tracks.is_empty():
		return
	_play_sequence += 1
	if _delay_timer != null:
		_delay_timer.stop()
	_play_next_random()


func is_playing() -> bool:
	return _player != null and _player.playing


func current_index() -> int:
	return _last_index


func playback_position() -> float:
	if _player == null or not _player.playing:
		return 0.0
	return _player.get_playback_position()


func current_length() -> float:
	if _player == null or _player.stream == null:
		return 0.0
	return _player.stream.get_length()

func audio_player() -> AudioStreamPlayer:
	return _player


func _play_deferred(sequence: int, start_index: int) -> void:
	if sequence != _play_sequence:
		return
	# Two-frame defer avoids first-play race conditions when callers start immediately
	# after node creation or scene transitions.
	await get_tree().process_frame
	if sequence != _play_sequence:
		return
	await get_tree().process_frame
	if sequence != _play_sequence:
		return
	if start_index >= 0 and start_index < _tracks.size():
		_play_track_at(start_index)
	else:
		_play_next_random()


func _play_next_random() -> void:
	if _tracks.size() == 0:
		return
	var idx: int = _pick_track_index()
	_play_track_at(idx)


func _play_track_at(idx: int) -> void:
	if idx < 0 or idx >= _tracks.size():
		return
	var stream: AudioStream = _tracks[idx]
	if stream == null:
		push_warning("AudioJukeboxSystem: encountered null stream.")
		return
	_player.stream = stream
	_player.volume_db = 0.0
	_player.play()
	_last_index = idx
	if not _player.playing:
		push_warning("AudioJukeboxSystem: play() did not start.")


func _pick_track_index() -> int:
	if _tracks.size() <= 1:
		return 0
	if not _shuffle_enabled:
		return (_last_index + 1) % _tracks.size()
	if _remaining_indices.is_empty():
		_refill_shuffle_bag()
		if _remaining_indices.size() > 1 and _remaining_indices.has(_last_index):
			_remaining_indices.erase(_last_index)
	var bag_index: int = _rng.randi_range(0, _remaining_indices.size() - 1)
	var idx: int = _remaining_indices[bag_index]
	_remaining_indices.remove_at(bag_index)
	return idx


func _refill_shuffle_bag() -> void:
	_remaining_indices.clear()
	for i in range(_tracks.size()):
		_remaining_indices.append(i)


func _on_track_finished() -> void:
	if _track_delay_seconds > 0.0 and _delay_timer != null:
		_delay_timer.start(_track_delay_seconds)
	else:
		_play_next_random()
