extends CPUParticles2D

signal effectDethed(effect)

func _process(delta):
	
	if emitting == false:
		
		emit_signal("effectDethed" , self)
		
		set_process(false)
