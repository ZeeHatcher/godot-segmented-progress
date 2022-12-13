extends GutTest


class TestFiller:
	extends GutTest
	
	
	const Filler = preload("res://addons/segmented_progress/fillers/filler.gd")
	
	var filler: Filler
	
	
	func before_each() -> void:
		filler = Filler.new()
	
	
	func after_each() -> void:
		filler.free()
	
	
	func test_can_create() -> void:
		assert_not_null(filler)
	
	
	func test_filled_dimensions_accessors() -> void:
		assert_accessors(filler, "filled_dimensions", Vector2(), Vector2.ONE)
	
	
	func test_empty_dimensions_accessors() -> void:
		assert_accessors(filler, "empty_dimensions", Vector2(), Vector2.ONE)


class TestLeftToRightFiller:
	extends GutTest
	
	
	const LeftToRightFiller = preload("res://addons/segmented_progress/fillers/left_to_right_filler.gd")
	
	var filler: LeftToRightFiller
	
	
	func before_each() -> void:
		filler = LeftToRightFiller.new()
	
	
	func after_each() -> void:
		filler.free()
	
	
	func test_can_create() -> void:
		assert_not_null(filler)
	
	
	func test_get_initial_position_returns_vector_zero() -> void:
		assert_eq(filler.get_initial_position(0, 0), Vector2.ZERO)
	
	
	func test_advance_increases_x_by_width() -> void:
		var dimensions := Vector2(2, 0)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.x, 2)
	
	
	func test_advance_does_not_change_y() -> void:
		var dimensions := Vector2(0, 1)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.y, 0)


class TestRightToLeftFiller:
	extends GutTest
	
	
	const RightToLeftFiller = preload("res://addons/segmented_progress/fillers/right_to_left_filler.gd")
	
	var filler: RightToLeftFiller
	
	
	func before_each() -> void:
		filler = RightToLeftFiller.new()
	
	
	func after_each() -> void:
		filler.free()
	
	
	func test_can_create() -> void:
		assert_not_null(filler)
	
	
	func test_get_initial_position_rect_width_minus_texture_width() -> void:
		filler.filled_dimensions = Vector2(1, 1)
		assert_eq(filler.get_initial_position(0, 3), Vector2(2, 0))
	
	
	func test_advance_decreases_x_by_width() -> void:
		var dimensions := Vector2(2, 0)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.x, -2)
	
	
	func test_advance_does_not_change_y() -> void:
		var dimensions := Vector2(0, 1)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.y, 0)


class TestTopToBottomFiller:
	extends GutTest
	
	
	const TopToBottomFiller = preload("res://addons/segmented_progress/fillers/top_to_bottom_filler.gd")
	
	var filler: TopToBottomFiller
	
	
	func before_each() -> void:
		filler = TopToBottomFiller.new()
	
	
	func after_each() -> void:
		filler.free()
	
	
	func test_can_create() -> void:
		assert_not_null(filler)
	
	
	func test_get_initial_position_returns_vector_zero() -> void:
		assert_eq(filler.get_initial_position(0, 0), Vector2.ZERO)
	
	
	func test_advance_increases_y_by_height() -> void:
		var dimensions := Vector2(0, 2)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.y, 2)
	
	
	func test_advance_does_not_change_x() -> void:
		var dimensions := Vector2(1, 0)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.x, 0)


class TestBottomToTopFiller:
	extends GutTest
	
	
	const BottomToTopFiller = preload("res://addons/segmented_progress/fillers/bottom_to_top_filler.gd")
	
	var filler: BottomToTopFiller
	
	
	func before_each() -> void:
		filler = BottomToTopFiller.new()
	
	
	func after_each() -> void:
		filler.free()
	
	
	func test_can_create() -> void:
		assert_not_null(filler)
	
	
	func test_get_initial_position_rect_height_minus_texture_height() -> void:
		filler.filled_dimensions = Vector2(1, 1)
		assert_eq(filler.get_initial_position(0, 3), Vector2(0, 2))
	
	
	func test_advance_decreases_y_by_height() -> void:
		var dimensions := Vector2(0, 2)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.y, -2)
	
	
	func test_advance_does_not_change_x() -> void:
		var dimensions := Vector2(1, 0)
		var pos := Vector2()
		pos = filler.advance(pos, dimensions)
		assert_eq(pos.x, 0)

