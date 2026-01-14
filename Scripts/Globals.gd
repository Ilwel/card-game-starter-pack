extends Node2D

func create_custom_tween(trans_param: Tween.TransitionType, ease_param: Tween.EaseType) -> Tween:
	var tween = get_tree().create_tween()
	tween.set_trans(trans_param)
	tween.set_ease(ease_param)
	return tween
	
func intersect_point_with_mask(mask: int) -> Array:
	var space_state = get_world_2d().direct_space_state
	var params := PhysicsPointQueryParameters2D.new()
	params.position = get_global_mouse_position()
	params.collide_with_areas = true
	params.collision_mask = mask
	return space_state.intersect_point(params)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
