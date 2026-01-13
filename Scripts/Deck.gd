extends Node2D

@export var hand:Hand

@onready var deck_cards = []

func _ready() -> void:
	load_deck_json()

func _process(_delta: float) -> void:
	pass

func load_deck_json(path: String = "res://Assets/DeckData/deck_example.json"):
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Erro ao abrir arquivo " + path)
		return

	var text := file.get_as_text()
	var parsed = JSON.parse_string(text)
	if parsed == null:
		push_error("JSON mal formatado!")
		return
	deck_cards = parsed
	
func draw():
	if deck_cards.size() == 0:
		return
	if hand:
		hand.add_card(deck_cards.pop_back(), self)
	
func draw_n(n: int):
	if deck_cards.size() < n:
		return
	if hand:
		for i in range(n):
			hand.add_card(deck_cards.pop_back(), self)


func _on_deck_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and hand:
		draw()	
