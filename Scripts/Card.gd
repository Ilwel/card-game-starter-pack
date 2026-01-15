class_name Card extends Node2D

@export var flipped = false

@onready var card_back_sprite = $CardBackSprite
@onready var face_card = $FaceCard
@onready var card_sprite = $FaceCard/CardSprite
@onready var card_collision = $CardArea/CardCollision
@onready var default_face_position = face_card.position.y
var card_id = ""

signal click

func _ready() -> void:
	get_parent().connect_card_signals(self)
	load_sprite()

func _process(_delta: float) -> void:
	card_back_sprite.visible = flipped

func _on_card_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		click.emit()

func flip():
	flipped = !flipped
	
func load_sprite():
	var card_path = "res://Assets/CardSprites/%s.png"  % card_id
	card_sprite.texture = load(card_path)
