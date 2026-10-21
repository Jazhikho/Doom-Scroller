extends RefCounted
class_name UIFontSystem

static func apply_fonts(root: Node, body_font: Font, display_font: Font, emphasis_font: Font) -> void:
	if root == null:
		return
	_apply_to_node(root, body_font, display_font, emphasis_font)
	for child in root.get_children():
		apply_fonts(child, body_font, display_font, emphasis_font)

static func _apply_to_node(node: Node, body_font: Font, display_font: Font, emphasis_font: Font) -> void:
	if node is RichTextLabel:
		_apply_rich_text_label(node as RichTextLabel, body_font, emphasis_font)
	elif node is Label:
		_apply_label(node as Label, body_font, display_font, emphasis_font)
	elif node is Button:
		_apply_button(node as Button, emphasis_font if emphasis_font != null else body_font)
	elif node is TabContainer:
		_apply_tab_container(node as TabContainer, emphasis_font if emphasis_font != null else body_font)

static func _apply_label(label: Label, body_font: Font, display_font: Font, emphasis_font: Font) -> void:
	var chosen_font := body_font
	if _is_display_node(label):
		chosen_font = display_font if display_font != null else emphasis_font
	if chosen_font != null:
		label.add_theme_font_override("font", chosen_font)

static func _apply_button(button: Button, button_font: Font) -> void:
	if button_font != null:
		button.add_theme_font_override("font", button_font)

static func _apply_tab_container(tab_container: TabContainer, tab_font: Font) -> void:
	if tab_font != null:
		tab_container.add_theme_font_override("font", tab_font)

static func _apply_rich_text_label(label: RichTextLabel, body_font: Font, emphasis_font: Font) -> void:
	if body_font != null:
		label.add_theme_font_override("normal_font", body_font)
	if emphasis_font != null:
		label.add_theme_font_override("bold_font", emphasis_font)

static func _is_display_node(node: Node) -> bool:
	var node_name := node.name.to_lower()
	return node_name.contains("title") or node_name.contains("intro")
