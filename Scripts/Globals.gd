extends Node2D

func create_custom_tween(trans_param: Tween.TransitionType, ease_param: Tween.EaseType) -> Tween:
	var tween = get_tree().create_tween()
	tween.set_trans(trans_param)
	tween.set_ease(ease_param)
	return tween

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
