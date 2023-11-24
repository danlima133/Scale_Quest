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

func load_room(current_scene):
	
	countRoom += 1
	
	if countRoom > (roomOrder.size() - 1):
		
		levelsCompleted[current_level] = true
		
		countRoom = -1
		roomOrder = []
		current_level = ""
		
		LoadScene.loadScene("res://mapaMundi/object/MapaMundi.tscn" , current_scene)
		
		return
	
	var key = roomOrder[countRoom]
	
	var path = rootPathLevels + current_level + "/" + key
	
	if ResourceLoader.exists(path):
		
		LoadScene.loadScene(path , current_scene)
		
#		var room = load(path) as PackedScene
#
#		print(room)
