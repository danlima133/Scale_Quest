extends Node

const rootPathLevels = "res://gameLevels/"

var levelsCompleted:Dictionary = {
	"Major_Plains":false,
	"Whole_Tone_Woods":false,
	"Gypsy_Major_Desert":false,
	"Minor_Volcano":false
}

var current_level:String
var roomOrder:Array

var countRoom:int = -1

var lastPoint:int

func load_room():
	
	countRoom += 1
	
	if countRoom > (roomOrder.size() - 1):
		
		levelsCompleted[current_level] = true
		
		countRoom = -1
		roomOrder = []
		current_level = ""
		
		get_tree().change_scene("res://mapaMundi/object/MapaMundi.tscn")
		
		return
	
	var key = roomOrder[countRoom]
	
	var path = rootPathLevels + current_level + "/" + key
	
	if ResourceLoader.exists(path):
		
		get_tree().change_scene(path)
		
#		var room = load(path)
		
#		print(room)
