class_name HandBalatro extends Hand

@export var highlight_cards_limit = 5
@onready var highlight_cards = []

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func reposition_cards() -> void:
	var count := card_manager.get_children().size()
	if count == 0:
		return

	var start_x := _calc_start_x(count)

	for i in range(card_manager.get_children().size()):
		var card = card_manager.get_children()[i]
		var target_y = ROW_Y
		if highlight_cards.has(card):
			target_y -= 64
		var target_pos := Vector2(start_x + i * (CARD_WIDTH + CARD_GAP), target_y)
		update_card_transform(card, target_pos)
