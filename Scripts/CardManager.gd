extends Node2D

@onready var screen_size: Vector2 = get_viewport_rect().size
var card_being_dragged = null
var current_time: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if card_being_dragged:
		current_time += delta
		var mouse_pos: Vector2 = get_global_mouse_position()
		card_being_dragged.global_position = Vector2(
			clamp(mouse_pos.x, 0, screen_size.x),
			clamp(mouse_pos.y, 0, screen_size.y)
		)
		card_being_dragged.rotation = 0
	elif is_instance_of(get_parent(), Hand):
		var hand: Hand =  get_parent()
		hand.reposition_cards()
		
	
func _input(event: InputEvent) -> void:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var card: Card = raycast_check_for_card()
				if card:
					start_drag(card)
			elif card_being_dragged:
					finish_drag()
	
func start_drag(card: Card):
	card_being_dragged = card
	
func handle_balatro_finish_drag():
	var hand: HandBalatro = get_parent()
	var highlight_full = hand.highlight_cards.size() == hand.highlight_cards_limit
	if not highlight_full and not get_parent().highlight_cards.has(card_being_dragged) and current_time > 0.2:
		get_parent().highlight_cards.push_back(card_being_dragged)	
	elif is_instance_of(get_parent(), HandBalatro) and get_parent().highlight_cards.has(card_being_dragged) and current_time > 0.2:
		remove_card_from_highlights(card_being_dragged)
	
func finish_drag():
	if not card_being_dragged:
		return
	if is_instance_of(get_parent(), HandBalatro):
		handle_balatro_finish_drag()
	current_time = 0.0
	card_being_dragged = null
	
func _get_highest_z_card(results: Array) -> Card:
	if results.size() == 0:
		return null
	var highest: Card = results[0].collider.get_parent()
	var highest_index: int = highest.z_index
	for i in range(1, results.size()):
		var current: Card = results[i].collider.get_parent()
		if current.z_index > highest_index:
			highest = current
			highest_index = current.z_index
	return highest
	
func raycast_check_for_card() -> Card:
	var result: Array = Globals.intersect_point_with_mask(1)
	if result.size() > 0:
		return _get_highest_z_card(result)
	return null

func connect_card_signals(card:Card):
	card.connect('click', handle_click.bind(card))
	
func remove_card_from_highlights(card):
	var hand = get_parent()
	var card_index = hand.highlight_cards.find(card)
	hand.highlight_cards.remove_at(card_index)
	
func handle_click_hand_balatro(card:Card):
	var hand: HandBalatro = get_parent()
	if hand.highlight_cards.has(card):
		remove_card_from_highlights(card)
	elif  hand.highlight_cards.size() < hand.highlight_cards_limit:
		hand.highlight_cards.push_back(card)
	hand.reposition_cards()
	
func handle_click(card: Card):
	if is_instance_of(get_parent(), HandBalatro):
		handle_click_hand_balatro(card)
	elif get_parent().flip_cards_on_click:
		card.flip()
