extends Sprite2D

@onready var interactable: Area2D = $Interactable
@onready var chest: Sprite2D = $Chest

func _ready() -> void:
	interactable.interact = _on_interact
	
	
func _on_interact():
	if chest.frame ==0:
		chest.frame = 2
		interactable.is_interactable = false
		print("Vous avez trouver l'oeuf !")
