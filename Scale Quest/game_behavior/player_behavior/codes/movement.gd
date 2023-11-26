extends Node

### nodes:

onready var moveObject = get_parent()
onready var texture = $"../texture"

onready var shape = $"../shape"

onready var movement_animation = $"../texture/movement_animation"

### end

### staticData

onready var posX_shape = shape.position.x

### end

### movementData

export(String , FILE , "*.move") var dataMovementPath

var dataMove:Dictionary

### end

### communData:

var direction:Vector2
var lastDirection:Vector2

var floorState = false

var inertia = Vector2(10 , 10)

var on_ledder = false
var gravity = true

###

### (func) getting fileData and func _read:

func _get_data():
	
	var file = File.new()
	
	if file.file_exists(dataMovementPath):
		
		var erro = file.open(dataMovementPath , File.READ)
		
		if erro == OK:
		
			var text = file.get_as_text()
			
			var result = JSON.parse(text)
			
			if result.error == 0:
				
				var type_data = typeof(result.result)
				
				if type_data == TYPE_DICTIONARY:
					
					dataMove = result.result
					
				else:
					
					printerr("Data invalid")
					
			else: print(("Erro Code: " + str(result.error) + "\nErro Line: " + str(result.error_line) + "\nErro: " + result.error_string))
		
		else: printerr("Can't read file")
	
	else: printerr("File '.move' not exists !")
	
	file.close()

func _ready():
	
	# getting data:
	
	_get_data()
	
	# end

### end

### movement funcs:

func _get_input():
	
	#move player:
	
	var player_movement = Input.get_axis("playerLeft" , "playerRight")
	
	if player_movement != 0:
		
		direction.x += (dataMove["acell"] * player_movement)
		
		direction.x = clamp(direction.x , -dataMove["velocity"] , dataMove["velocity"])
		
		lastDirection = direction

		if moveObject.is_on_floor():
			
			floorState = false
		
			change_state("run")
		
		#flipSprite and correct shape:
	
		if lastDirection.x > 0:
		
			texture.flip_h = false
	
		else:
		
			texture.flip_h = true
	
		shape.position.x = (posX_shape * player_movement)
		
		#end
	
	else:
		
		direction.x = lerp(direction.x , 0 , dataMove["friction"])
		
		if moveObject.is_on_floor() and floorState == false:
		
			change_state("idle")
	
	#end
	
	#jump and ledder:
	
	match on_ledder:
		
		false:
			
			gravity = true
	
			if Input.is_action_just_pressed("playerJump"):
				
				if moveObject.is_on_floor():
					
					ServeAudio.play_sound_at_position(preload("res://assets/sfx/jump.ogg") , moveObject.global_position , "SFXs")
					
					direction.y -= dataMove["jump"]
					
					floorState = true
					
					change_state("jump")
			
			if !moveObject.is_on_floor() and on_ledder == false:
				
				if direction.y > 0:
					
					change_state("fall")
				
			elif direction.y > 0:
				
				if floorState == true:
				
					change_state("floor")
				
					yield(movement_animation , "animation_finished")
					
					floorState = false
		
		true:
			
			if direction.x == 0:
			
				change_state("idle")
			
			if Input.is_action_pressed("ui_up"):
				
				change_state("idle")
				
				direction.y = -35
				
				gravity = false
			
			elif Input.is_action_pressed("ui_down"):
				
				change_state("idle")
				
				direction.y = 35
				
				gravity = false
			
			else:
				
				gravity = true

	
	#end
	
	direction = moveObject.move_and_slide(direction , Vector2.UP , false , 4 , PI/4 , false)
	

func _gravity(delta):
	
	#smartGravity:
	
	if gravity:
	
		if direction.y < 0 or direction.y == 0:
			
			direction.y += (dataMove["gravity"] * delta)
		
		elif direction.y > 0:
			
			direction.y += ((dataMove["gravity"] * 2) * delta)
		
	#end

### end

### changeStateAnim:

func change_state(state_key:String):
	
	movement_animation.play(state_key)

### end

func _physics_process(delta):
	
	#call movement funcs:
	
	_get_input()
	
	_gravity(delta)
	
	#moveBox:
	
	for i in moveObject.get_slide_count():

		var colision = moveObject.get_slide_collision(i)

		if colision.collider.is_in_group("box"):

			colision.collider.apply_central_impulse(-colision.normal * inertia)
	
	#end
