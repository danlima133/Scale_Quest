extends Area2D

const popUpPreObject = preload("res://gameUI/levelPopUp/objects/levelPop_up.tscn")

export(MangerLevel.LevelsGame) var dootLevel

func _on_dootLevel_mouse_entered():
	
	var popup = popUpPreObject.instance()
	
	popup.rect_global_position = global_position + Vector2(-30 , -80)
	
	add_child(popup)
	
	popup.get_ref(MangerLevel.levelsName[dootLevel])
	
	popup.popup()

func _on_dootLevel_mouse_exited():
	
	if has_node("levelPop_up"): get_node("levelPop_up").queue_free()

func _on_dootLevel_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton and MangerLevel.conlusedGame == true:
		
		if event.pressed and event.button_index == BUTTON_LEFT:
	
			get_tree().call_group("playerPath" , "_go_to_point" , MangerLevel.levelsName[dootLevel])
