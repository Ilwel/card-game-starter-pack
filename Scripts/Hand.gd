class_name Hand extends Node2D

const CARD_WIDTH = 96
const CARD_HEIGHT = 128
const CARD_GAP = 10
var row_y = 550

var CardScene = preload("res://Scenes/Cards/Card.tscn")

@export var flip_cards_on_click = false

@onready var card_manager = $CardManager

func _ready() -> void:
	row_y = get_viewport_rect().size.y - (CARD_HEIGHT / 2.0)

func _process(_delta: float) -> void:
	pass
	
## Move card to hand ##

func _calc_start_x(count:int)->float:
	var screen_w := get_viewport_rect().size.x
	var total_w := count * CARD_WIDTH + (count - 1) * CARD_GAP
	return (screen_w - total_w) * 0.5 + CARD_WIDTH * 0.5
	
func update_card_transform(card: Card, target_pos: Vector2) -> Tween:
	target_pos = Vector2(round(target_pos.x), round(target_pos.y))
	var tween := Globals.create_custom_tween(Tween.TRANS_BACK, Tween.EASE_OUT)

	tween.tween_property(card, "global_position", target_pos, 0.15)
	return tween
	
func reposition_cards() -> void:
	var count := card_manager.get_children().size()
	if count == 0:
		return

	var start_x := _calc_start_x(count)

	for i in range(card_manager.get_children().size()):
		var card = card_manager.get_children()[i]
		var target_pos := Vector2(start_x + i * (CARD_WIDTH + CARD_GAP), row_y)
		update_card_transform(card, target_pos)
	
func add_card(card_id, source) -> void:
	var card: Card = CardScene.instantiate()
	card.card_id = card_id
	card_manager.add_child(card)
	card.position = source.position
	reposition_cards()
