extends Camera2D

var can_shake = false

var forceShake:float
var durationShake:float

func _ready():
	
	set_process(false)

func _process(delta):
	
	if can_shake == true:
		
		var xOffset = rand_range(1 , -1)
		var yOffset = rand_range(1 , -1)
		
		offset = Vector2(xOffset , yOffset) * forceShake
		
		yield(get_tree().create_timer(durationShake) , "timeout")
		
		can_shake = false
		
		offset = Vector2.ZERO
		
		forceShake = 0
		
		durationShake = 0

func shakeCamera(force:float , duration:float):
	
	can_shake = true
	
	forceShake = force
	
	durationShake = duration
	
	set_process(true)
