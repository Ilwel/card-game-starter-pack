class_name HandHighlight extends Hand

func _ready() -> void:
	super._ready()

func _process(_delta: float) -> void:
	pass

func update_card_transform_highlight(card: Card, target_pos: Vector2, face_pos_y) -> Tween:
	target_pos = Vector2(round(target_pos.x), round(target_pos.y))
	var tween := Globals.create_custom_tween(Tween.TRANS_BACK, Tween.EASE_OUT)
	
	tween.tween_property(card, "global_position", target_pos, 0.15)
	tween.tween_property(card.face_card, "position:y", face_pos_y, 0.15)
	return tween
	
func reposition_cards(highlight: Card = null) -> void:
	var count := card_manager.get_children().size()
	if count == 0:
		return

	var start_x := _calc_start_x(count)

	for i in range(card_manager.get_children().size()):
		var card: Card = card_manager.get_children()[i]
		var face_target_pos = card.default_face_position
		if card == highlight:
			face_target_pos -= CARD_HEIGHT / 2.0
		var target_pos := Vector2(start_x + i * (CARD_WIDTH + CARD_GAP), row_y)
		update_card_transform_highlight(card, target_pos, face_target_pos)
