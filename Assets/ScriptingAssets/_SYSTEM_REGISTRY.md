# Godot 4 System Registry

| System | File | Status | Source | Responsibility |
| --- | --- | --- | --- | --- |
| Audio jukebox | `AudioJukeboxSystem.gd` | Promoted | Signal Rift | Background music/ambient playlist playback with shuffle, delay, and basic transport state. |
| Audio mix UI | `AudioMixControlSystem.gd` | Preserved | Legacy systems folder | UI glue for music/SFX sliders and master mute. |
| Catalog lookup | `CatalogLookupSystem.gd` | Preserved | Legacy systems folder | ID-keyed catalog registration and query helper. |
| Dialogue data | `DialogueContentSystem.gd` | Preserved | Legacy systems folder | Data-only dialogue/random line pools from JSON or dictionaries. |
| Dialogue presenter | `TimedDialoguePresenterSystem.gd` | Preserved | Legacy systems folder | Timed dialogue panel presentation and optional Yes/No flow. |
| Environment phase presenter | `EnvironmentPhasePresenterSystem.gd` | Preserved | Legacy systems folder | Progress-based float/color interpolation. |
| First-person input bootstrap | `FirstPersonInputBootstrap.gd` | Promoted | No Place by the Fire | Optional default InputMap registration for first-person movement/look actions. |
| First-person look settings | `FirstPersonLookSettings.gd` | Promoted | No Place by the Fire | Designer-editable look sensitivity, invert-Y, pitch bounds, and walk speed resource. |
| First-person motor math | `FirstPersonMotorMath.gd` | Promoted | No Place by the Fire | Pure yaw-relative movement and look-orientation math. |
| First-person movement controller | `FirstPersonMovementController.gd` | Promoted | No Place by the Fire | CharacterBody3D first-person walk/look controller with mouse/gamepad support. |
| Interaction target | `InteractionTargetSystem.gd` | Preserved | Legacy systems folder | Focus/nearby target resolution and generic dispatch. |
| Inventory state | `InventoryStateSystem.gd` | Preserved | Legacy systems folder | Pure inventory state helper with no UI/save ownership. |
| Item placement puzzle | `ItemPlacementPuzzleSystem.gd` | Preserved | Legacy systems folder | Required-item placement rule state. |
| JSON file store | `JsonFileStoreSystem.gd` | Preserved | Legacy systems folder | Generic JSON read/write/delete and backup/restore. |
| Offline stat save | `OfflineSaveSystem.gd` | Preserved | Legacy systems folder | Stat-focused JSON save/load/delete with optional offline drain. |
| Phase tick | `PhaseTickSystem.gd` | Preserved | Legacy systems folder | Deterministic phase-ordered callback runner. |
| Point defense | `PointDefenseSystem.gd` | Promoted | Signal Rift | Cooldown and target-priority helper for automatic defense systems. |
| Random cue scheduler | `RandomCueSchedulerSystem.gd` | Preserved | Legacy systems folder | Random cue selection and next-delay generation. |
| Scene fade transition | `SceneFadeTransitionSystem.gd` | Preserved | Legacy systems folder | Transition phase sequencing state. |
| Settings persistence | `SettingsPersistenceSystem.gd` | Preserved | Legacy systems folder | Settings defaults/current state get/set/reset/import/export. |
| Shield regen | `ShieldRegenSystem.gd` | Promoted | Signal Rift | Shield recharge delay and rate helper. |
| Stat simulation | `StatSimulationSystem.gd` | Preserved | Legacy systems folder | Pure numeric stat state, drain, deltas, and clamps. |
| Target lock | `TargetLockSystem.gd` | Promoted | Signal Rift | Weak-reference target state plus nearest/cycle selection. |
| Threshold state | `ThresholdStateSystem.gd` | Preserved | Legacy systems folder | Numeric threshold band/crossing tracking. |
| Timed message queue | `TimedMessageQueueSystem.gd` | Preserved | Legacy systems folder | Timed message sequencing state with skip/advance. |
| UI font | `UIFontSystem.gd` | Promoted | Signal Rift | Recursive Control-tree font override helper. |
| Weighted selection | `WeightedSelectionSystem.gd` | Preserved | Legacy systems folder | Deterministic weighted picks with filtering and repeat suppression. |

## 2026-07-21 Baseline Expansion

All systems in this section are generated reusable starting points. Each script is marked untested and should be validated in a target project before production use.

| System | File | Status | Source | Responsibility |
| --- | --- | --- | --- | --- |
| Project metadata | `ProjectMetadataSystem.gd` | Generated | Codex 2026-07-21 | Project id, display name, version, build channel, and save compatibility state. |
| Event bus | `EventBusSystem.gd` | Generated | Codex 2026-07-21 | Pub/sub callbacks with bounded event history. |
| Save envelope | `SaveEnvelopeSystem.gd` | Generated | Codex 2026-07-21 | Versioned save envelope, compatibility checks, and migration callback sequencing. |
| Input rebinding | `InputRebindingSystem.gd` | Generated | Codex 2026-07-21 | Runtime action bindings, defaults, reset, export, and InputMap application. |
| Action prompts | `ActionPromptSystem.gd` | Generated | Codex 2026-07-21 | Device-specific action prompt text. |
| Cooldowns | `CooldownSystem.gd` | Generated | Codex 2026-07-21 | Cooldown timers, charges, consume, tick, and refill. |
| State machine | `StateMachineSystem.gd` | Generated | Codex 2026-07-21 | Finite-state transitions with allowed target checks. |
| Object pool | `ObjectPoolSystem.gd` | Generated | Codex 2026-07-21 | Callable-backed node acquire/release pool. |
| Spawn scheduler | `SpawnSchedulerSystem.gd` | Generated | Codex 2026-07-21 | Timed spawn groups with active caps. |
| Runtime flags | `RuntimeFlagSystem.gd` | Generated | Codex 2026-07-21 | Boolean/numeric/string flag storage with import/export. |
| Quest objectives | `QuestObjectiveStateSystem.gd` | Generated | Codex 2026-07-21 | Active/completed/failed objective counters. |
| Progression unlocks | `ProgressionUnlockSystem.gd` | Generated | Codex 2026-07-21 | Requirement-gated unlock state. |
| Localization text | `LocalizationTextSystem.gd` | Generated | Codex 2026-07-21 | String tables, fallback language, and variable interpolation. |
| Notification queue | `NotificationQueueSystem.gd` | Generated | Codex 2026-07-21 | Priority notifications with dedupe and expiry. |
| Runtime log | `RuntimeLogSystem.gd` | Generated | Codex 2026-07-21 | Bounded categorized runtime log entries. |
| Telemetry events | `TelemetryEventSystem.gd` | Generated | Codex 2026-07-21 | Local event capture and export. |
| Pause stack | `PauseStackSystem.gd` | Generated | Codex 2026-07-21 | Nested pause reasons and top reason. |
| Focus lifecycle | `FocusLifecycleSystem.gd` | Generated | Codex 2026-07-21 | Focus notification outcomes for audio/input release policies. |
| Device detection | `DeviceDetectionSystem.gd` | Generated | Codex 2026-07-21 | Active keyboard/mouse versus controller tracking. |
| Resource preload queue | `ResourcePreloadQueueSystem.gd` | Generated | Codex 2026-07-21 | Simple resource load queue with loaded/failed state. |
| Scene service registry | `SceneServiceRegistry.gd` | Generated | Codex 2026-07-21 | Local service registration and lookup. |
| Data validation | `DataValidationSystem.gd` | Generated | Codex 2026-07-21 | Boot/resource validation issue collection. |
| Debug validation harness | `DebugValidationHarness.gd` | Generated | Codex 2026-07-21 | Callable smoke-check runner. |
| Combat health | `CombatHealthSystem.gd` | Generated | Codex 2026-07-21 | Health, damage, healing, and empty-state helper. |
| Damage packets | `DamagePacketSystem.gd` | Generated | Codex 2026-07-21 | Damage packet construction and scaling. |
| Status effects | `StatusEffectSystem.gd` | Generated | Codex 2026-07-21 | Stack/duration status-effect state. |
| Hit resolution | `HitResolutionSystem.gd` | Generated | Codex 2026-07-21 | Flat hit result and damage resolution helpers. |
| Resistance | `ResistanceSystem.gd` | Generated | Codex 2026-07-21 | Damage-type multipliers and packet adjustment. |
| Initiative turn order | `InitiativeTurnOrderSystem.gd` | Generated | Codex 2026-07-21 | Sorted actor turn order and next actor index. |
| Branching dialogue state | `BranchingDialogueStateSystem.gd` | Generated | Codex 2026-07-21 | Current/visited dialogue node state. |
| Speaker registry | `SpeakerRegistrySystem.gd` | Generated | Codex 2026-07-21 | Speaker id to display-name metadata. |
| Dialogue conditions | `DialogueConditionSystem.gd` | Generated | Codex 2026-07-21 | Runtime-flag based dialogue condition checks. |
| Dialogue choices | `DialogueChoiceSystem.gd` | Generated | Codex 2026-07-21 | Choice filtering by conditions. |
| Dialogue consequences | `DialogueConsequenceSystem.gd` | Generated | Codex 2026-07-21 | Flag-setting and increment consequences. |
| Item stacks | `ItemStackSystem.gd` | Generated | Codex 2026-07-21 | Stack add/remove/count state. |
| Equipment slots | `EquipmentSlotSystem.gd` | Generated | Codex 2026-07-21 | Slot definitions, equip, and unequip. |
| Container inventory | `ContainerInventorySystem.gd` | Generated | Codex 2026-07-21 | Container item arrays with capacity. |
| Inventory transactions | `InventoryTransactionSystem.gd` | Generated | Codex 2026-07-21 | Container-to-container transfer helper. |
| Currency wallet | `CurrencyWalletSystem.gd` | Generated | Codex 2026-07-21 | Currency balances, add, spend, and query. |
| Price table | `PriceTableSystem.gd` | Generated | Codex 2026-07-21 | Item price lookup by currency and amount. |
| Economy transactions | `EconomyTransactionSystem.gd` | Generated | Codex 2026-07-21 | Buy/sell wallet operations. |
| Buy/sell validation | `BuySellValidationSystem.gd` | Generated | Codex 2026-07-21 | Affordability and price existence checks. |
| World locations | `WorldLocationSystem.gd` | Generated | Codex 2026-07-21 | Location id/display/metadata state. |
| Travel links | `TravelLinkSystem.gd` | Generated | Codex 2026-07-21 | Directed travel links and costs. |
| Discovery state | `DiscoveryStateSystem.gd` | Generated | Codex 2026-07-21 | Discovered/visited state. |
| Map markers | `MapMarkerSystem.gd` | Generated | Codex 2026-07-21 | Map marker id/location/type/data state. |
| Tutorial steps | `TutorialStepStateSystem.gd` | Generated | Codex 2026-07-21 | Tutorial step availability/active/completed state. |
| Tutorial conditions | `TutorialConditionSystem.gd` | Generated | Codex 2026-07-21 | Prerequisite-completion checks for tutorial steps. |
| Tutorial suppression | `TutorialSuppressionSystem.gd` | Generated | Codex 2026-07-21 | Suppressed tutorial id state. |
| Tutorial completion | `TutorialCompletionSystem.gd` | Generated | Codex 2026-07-21 | Completed tutorial id state. |

## Candidate Systems To Extract Later

When a game project produces a reusable system, add it here only after stripping project-specific names, paths, lore, and consequences.
