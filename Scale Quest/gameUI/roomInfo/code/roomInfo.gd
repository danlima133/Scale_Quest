extends CanvasLayer

onready var text = $base/text
onready var anim = $base/anim

func _ready():
	
	yield(LoadScene , "loadCompleted")
	
	text.text = (MangerLevel.current_level.replace("_" , " ") + "\n" + "Room - " + str(MangerLevel.countRoom + 1))
	
	anim.play("welcome")
	
	yield(anim , "animation_finished")
	
	queue_free()
