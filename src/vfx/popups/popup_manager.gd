class_name PopupManager extends Node2D

@export var popup_instance: Resource

func _ready():
	Global.popup_manager = self

func create_popup(text: String, new_position: Vector2, x_velocity: float):
	var new_popup: TextPopup = popup_instance.instantiate()
	add_child(new_popup)
	new_popup.global_position = new_position
	new_popup.x_velocity = x_velocity
	new_popup.text_content = text

func _process(delta):
	pass
