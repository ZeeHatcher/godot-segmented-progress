tool
extends Control


signal changed
signal value_changed(value)

enum FillMode {
	LEFT_TO_RIGHT,
	RIGHT_TO_LEFT,
	TOP_TO_BOTTOM,
	BOTTOM_TO_TOP,
}

export(FillMode) var fill_mode: int setget set_fill_mode, get_fill_mode
export var filled: Texture setget set_filled, get_filled
export var filled_tint := Color.white setget set_filled_tint, get_filled_tint
export var empty: Texture setget set_empty, get_empty
export var empty_tint := Color.white setget set_empty_tint, get_empty_tint
export var max_value: int setget set_max_value, get_max_value
export var value: int setget set_value, get_value


func _draw() -> void:
	var pos := _get_initial_pos()
	
	for n in range(max_value):
		var is_filled := n + 1 <= value
		var texture: Texture = filled if is_filled else empty
		var tint: Color = filled_tint if is_filled else empty_tint
		
		if not texture:
			continue
		
		draw_texture(texture, pos, tint)
		pos = _advance_pos(pos, texture.get_size())


func update() -> void:
	.update()
	_update_rect_size()


func set_fill_mode(val: int) -> void:
	fill_mode = val
	update()


func get_fill_mode() -> int:
	return fill_mode


func set_filled(val: Texture) -> void:
	filled = val
	update()


func get_filled() -> Texture:
	return filled


func set_empty(val: Texture) -> void:
	empty = val
	update()


func get_empty() -> Texture:
	return empty


func set_filled_tint(val: Color) -> void:
	filled_tint = val
	update()


func get_filled_tint() -> Color:
	return filled_tint


func set_empty_tint(val: Color) -> void:
	empty_tint = val
	update()


func get_empty_tint() -> Color:
	return empty_tint


func set_max_value(val: int) -> void:
	max_value = max(0, val)
	emit_signal("changed")
	update()


func get_max_value() -> int:
	return max_value


func set_value(val: int) -> void:
	var prev := value
	value = clamp(val, 0, max_value)
	
	if value == prev:
		return
		
	emit_signal("value_changed", value)
	update()


func get_value() -> int:
	return value


func _update_rect_size() -> void:
	var height := 0.0
	var width := 0.0
	
	if filled and empty:
		height = max(filled.get_height(), empty.get_height())
		width = filled.get_width() * value + empty.get_width() * (max_value - value)
	elif filled:
		height = filled.get_height()
		width = filled.get_width() * max_value
	elif empty:
		height = empty.get_height()
		width = empty.get_width() * max_value
	
	rect_min_size = Vector2(width, height)
	rect_size = rect_min_size


func _get_initial_pos() -> Vector2:
	var texture: Texture = null
	
	if filled:
		texture = filled
	elif empty:
		texture = empty
	
	match fill_mode:
		FillMode.RIGHT_TO_LEFT:
			return Vector2(rect_size.x - texture.get_width(), 0)
		FillMode.BOTTOM_TO_TOP:
			return Vector2(0, rect_size.y - texture.get_height())
	
	return Vector2()


func _advance_pos(pos: Vector2, texture_dimensions: Vector2) -> Vector2:
	match fill_mode:
		FillMode.LEFT_TO_RIGHT:
			pos.x += texture_dimensions.x
		FillMode.RIGHT_TO_LEFT:
			pos.x -= texture_dimensions.x
		FillMode.TOP_TO_BOTTOM:
			pos.y += texture_dimensions.y
		FillMode.BOTTOM_TO_TOP:
			pos.y -= texture_dimensions.y
	
	return pos
