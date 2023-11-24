extends CanvasLayer

export(NodePath) var roomTime

onready var count_keys = $base/keys/countKeys
onready var timer_count = $base/timer/timerCount

func set_keyValue(count:int):
	
	count_keys.text = str(count)

func _ready():
	
	set_keyValue(0)
	
	set_process(false)
	
	roomTime = get_node(roomTime)
	
	set_process(true)

func _process(delta):
	
	timer_count.text = str(roomTime.timer_count)
