extends Node2D

export(int) var speedMax
export(int) var speedMin

var cloudsRects = [
	Rect2(79 , 24 , 84 , 34),
	Rect2(132 , 88 , 132 , 58),
	Rect2(26 , 99 , 84 , 39)
]

onready var texture = $texture
onready var ocluder = $ocluder

var speed:int

func _choice_texture():
	
	cloudsRects.shuffle()

	var indexTexture = cloudsRects[randi() % cloudsRects.size()] as Rect2
	
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
