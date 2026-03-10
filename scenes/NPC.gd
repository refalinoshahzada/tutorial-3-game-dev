extends Node2D

var player_near = false

@onready var dialogue_box = get_node("/root/Root/DialogueUI/DialogueBox")
@onready var talk_sound = $TalkSound

func _process(delta):

	if player_near and Input.is_action_just_pressed("talk"):
		dialogue_box.visible = !dialogue_box.visible
		talk_sound.play()


func _on_interaction_area_body_entered(body):

	if body.name == "NewPlayer":
		player_near = true


func _on_interaction_area_body_exited(body):

	if body.name == "NewPlayer":
		player_near = false
		dialogue_box.visible = false
