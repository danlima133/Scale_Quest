extends Node2D

const ledderSizeY = 16
const ledderSizeX = 14

export(bool) var can_generate = true

onready var checkFloor = $floor
onready var shape = $area/shape

onready var ledder_body = $ledderBody

var countTiles:int

func _make_ledder_tile():
	
	countTiles += 1
	
	ledder_body.region_rect.size.y += 16
	
	checkFloor.global_position.y += 16

func _ready():
	
	set_process(can_generate)

func _process(delta):
	
	if !checkFloor.is_colliding():
	
		_make_ledder_tile()
		
	else:
		
		var col = RectangleShape2D.new()
		
		col.extents = Vector2(7 , (countTiles * 8))
		
		shape.position.y = (countTiles * 16)/2
		
		shape.shape = col
		
		set_process(false)

func _on_area_body_entered(body):
	
	if body.is_in_group("player"):
		
		body.get_node("movementBehavior").on_ledder = true


func _on_area_body_exited(body):
	
	if body.is_in_group("player"):
		
		body.get_node("movementBehavior").on_ledder = false
