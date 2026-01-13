extends Node2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func connect_card_signals(card:Card):
	card.connect('click', handle_click.bind(card))
	
func handle_click_hand_balatro(card:Card):
	var hand: HandBalatro = get_parent()
	if hand.highlight_cards.has(card):
		var card_index = hand.highlight_cards.find(card)
		hand.highlight_cards.remove_at(card_index)
	elif  hand.highlight_cards.size() < hand.hihglight_cards_limit:
		hand.highlight_cards.push_back(card)
	hand.reposition_cards()
	
func handle_click(card: Card):
	if is_instance_of(get_parent(), HandBalatro):
		handle_click_hand_balatro(card)
	elif get_parent().flip_cards_on_click:
		card.flip()
