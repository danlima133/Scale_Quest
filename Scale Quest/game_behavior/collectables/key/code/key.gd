extends Area2D

func _on_key_body_entered(body):
	
	if body.is_in_group("player"):
		
		ServeAudio.play_sound_at_position(preload("res://assets/sfx/collect_key.ogg") , global_position , "SFXs")
		
		var manager = owner.get_node("ManagerCollectables")
		
		manager.set_key(1)
		
		queue_free()
