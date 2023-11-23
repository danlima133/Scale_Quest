extends Node2D

export(int) var speedMax
export(int) var speedMin

const cloudSmall = Rect2(140 , 0 , 90 , 50)
const cloudBig = Rect2(0 , 50 , 140 , 80)

onready var texture = $texture
onready var ocluder = $ocluder

var speed:int

func _choice_texture():
	
	var rects = [cloudSmall , cloudBig]
	
	var indexTexture = rects[randi() % rects.size()] as Rect2
	
	texture.region_rect = indexTexture
	
	ocluder.scale = indexTexture.size.abs()/32

func _move(delta):
	
	global_position.x -= (1 * speed) * delta

func _ready():
	
	randomize()
	
	_choice_texture()
	
	speed = rand_range(speedMax , speedMin)

func _process(delta):
	
	_move(delta)

func _on_ocluder_screen_exited():
	
	print_debug()
	
	queue_free()
