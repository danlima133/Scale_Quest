extends CanvasLayer

onready var text = $base/text
onready var anim = $base/anim

func _ready():
	
	if LoadScene.has_load == true: yield(LoadScene , "loadCompleted")
	
	text.text = (MangerLevel.current_level.replace("_" , " ") + "\n" + "Room - " + str(MangerLevel.countRoom + 1))
	
	anim.play("welcome")
	
	if ServeAudio.getRommSound() == null:
	
		ServeAudio.play_SoundRoom(MangerLevel.current_level)
	
	yield(anim , "animation_finished")
	
	queue_free()
