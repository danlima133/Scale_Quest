extends Node

enum LevelsGame {
	Major_Plains
	Whole_Tone_Woods
	Gypy_Major_Desert
	Minor_Volcano
}

const levelsName:Array = [
	"Major_Plains",
	"Whole_Tone_Woods",
	"Gypsy_Major_Desert",
	"Minor_Volcano"
	]

const rootPathLevels = "res://gameLevels/"

var levelsCompleted:Dictionary = {
	"Major_Plains":false,
	"Whole_Tone_Woods":false,
	"Gypsy_Major_Desert":false,
	"Minor_Volcano":false
}

var levelsAvarageTime:Dictionary = {
	"Major_Plains":[],
	"Whole_Tone_Woods":[],
	"Gypsy_Major_Desert":[],
	"Minor_Volcano":[]
}

var levelsTimeReal:Dictionary = {
	"Major_Plains":0,
	"Whole_Tone_Woods":0,
	"Gypsy_Major_Desert":0,
	"Minor_Volcano":0
}

var current_level:String = "Major_Plains"
var roomOrder:Array

var countRoom:int = -1

var lastPoint:int

var conlusedGame:bool = false
var levelConslused:bool = false

func get_roomsCount_byLevel(nameLevel:String) -> int:
	
	var countRooms:int
	
	var dir = Directory.new()
	
	var erro = dir.open(rootPathLevels + nameLevel)
	
	if erro == OK:
		
		dir.list_dir_begin(true)
		
		var filePath = dir.get_next()
		
		while filePath != "":
			
			countRooms += 1
			
			filePath = dir.get_next()
	
	return countRooms

func load_room(current_scene):
	
	countRoom += 1
	
	if countRoom > (roomOrder.size() - 1):
		
		print_debug()
		
		ServeAudio.stop_SounRoom(true)
		
		levelsCompleted[current_level] = true
		
		levelConslused = true
		
		countRoom = -1
		roomOrder = []
#		current_level = ""
		
		LoadScene.loadScene("res://mapaMundi/object/MapaMundi.tscn" , current_scene)
		
		ServeData.saveGame()
		
		return
	
	var key = roomOrder[countRoom]
	
	var path = rootPathLevels + current_level + "/" + key
	
	if ResourceLoader.exists(path):
		
		LoadScene.loadScene(path , current_scene)
		
#		var room = load(path) as PackedScene
#
#		print(room)
