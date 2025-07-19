extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var open_timer: Timer = $Timer
@onready var sfx_open: AudioStreamPlayer2D = $sfx_open
@onready var sfx_close: AudioStreamPlayer2D = $sfx_close

var is_door_open := false
var animation_frame := 0
var opening := true

const OPEN_START := 0
const OPEN_END := 7
const CLOSE_START := 8
const CLOSE_END := 13

func _ready() -> void:
	interactable.interact = _on_interact
	open_timer.timeout.connect(_on_open_timer_timeout)
	open_timer.wait_time = 0.1
	
func _on_interact():
	interactable.is_interactable = false	
	
	if not is_door_open:
		# OUVERTURE
		sfx_open.play()
		animation_frame = OPEN_START
		opening = true
	else:
		# FERMETURE
		sfx_close.play()
		animation_frame = CLOSE_START
		opening = false
		
	sprite_2d.frame = animation_frame
	open_timer.start()
	
func _on_open_timer_timeout():
	if opening:
		animation_frame += 1
		if animation_frame <= OPEN_END:
			sprite_2d.frame = animation_frame
			open_timer.start()
		else:
			is_door_open = true
			collision_shape.disabled = true
			interactable.interact_name = "Close Door"
			interactable.is_interactable = true
	else:
		animation_frame += 1
		if animation_frame <= CLOSE_END:
			sprite_2d.frame = animation_frame
			open_timer.start()
		else:
			is_door_open = false
			collision_shape.disabled = false
			sprite_2d.frame = 0  # 🔁 Revenir à la frame fermée visuellement
			interactable.interact_name = "Open Door"
			interactable.is_interactable = true
