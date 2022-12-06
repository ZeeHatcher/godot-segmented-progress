extends GutTest


const SegmentedProgress := preload("res://addons/segmented_progress/segmented_progress.gd")


func test_can_create() -> void:
	assert_not_null(SegmentedProgress.new())


func test_filled_accessors() -> void:
	assert_accessors(SegmentedProgress.new(), "filled", null, double(ImageTexture).new())


func test_filled_tint_accessors() -> void:
	assert_accessors(SegmentedProgress.new(), "filled_tint", Color.white, Color.pink)


func test_empty_accessors() -> void:
	assert_accessors(SegmentedProgress.new(), "empty", null, double(ImageTexture).new())


func test_empty_tint_accessors() -> void:
	assert_accessors(SegmentedProgress.new(), "empty_tint", Color.white, Color.pink)


func test_max_value_accessors() -> void:
	assert_accessors(SegmentedProgress.new(), "max_value", 0, 1)


func test_max_value_should_not_fall_below_zero() -> void:
	var progress := SegmentedProgress.new()
	progress.max_value = -1
	assert_eq(progress.max_value, 0)


func test_set_max_value_should_emit_changed() -> void:
	var progress := SegmentedProgress.new()
	watch_signals(progress)
	progress.max_value = 1
	assert_signal_emitted(progress, "changed")


func test_value_should_not_fall_below_zero() -> void:
	var progress := SegmentedProgress.new()
	progress.value = -1
	assert_eq(progress.value, 0)


func test_value_should_not_exceed_max_value() -> void:
	var progress := _create_progress_with_max_value(1)
	progress.value = 2
	assert_eq(progress.value, progress.max_value)


func test_set_value_should_emit_value_changed() -> void:
	var progress := _create_progress_with_max_value(1)
	watch_signals(progress)
	progress.value = 1
	assert_signal_emitted_with_parameters(progress, "value_changed", [1])


func test_set_value_should_not_emit_value_changed_if_value_did_not_change() -> void:
	var progress := SegmentedProgress.new()
	watch_signals(progress)
	progress.value = 0
	assert_signal_not_emitted(progress, "value_changed")


func _create_progress_with_max_value(max_value) -> SegmentedProgress:
	var progress := SegmentedProgress.new()
	progress.max_value = max_value
	
	return progress
