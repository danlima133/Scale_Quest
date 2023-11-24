extends Node

signal loadCompleted()

const loadScreen = preload("res://gameUI/load_screem/load_screen.tscn")

var loaderRef:ResourceInteractiveLoader

var countLoader:int
var screen_load
var scene

var transition:AnimationPlayer

var has_load = false

func _ready():
	
	set_process(false)

func _process(delta):
	
	countLoader = loaderRef.get_stage_count()

	if loaderRef.poll() != OK:
		
		set_process(false)
		
		var sceneLoad = loaderRef.get_resource().instance()
		
		scene.queue_free()
		
		transition.play_backwards("fade")
		
		get_tree().root.add_child(sceneLoad)
		
		yield(transition , "animation_finished")
		
		screen_load.queue_free()
		
		loaderRef = null
		
		countLoader = 0
		
		emit_signal("loadCompleted")
		
		has_load = false

func loadScene(sceneLoad:String , currentScene):
	
	has_load = true
	
	scene = currentScene
	
	screen_load = loadScreen.instance()
	
	get_tree().root.add_child(screen_load)
	
	transition = get_tree().root.get_node("load_screen").get_node("base/transition") as AnimationPlayer
	
	yield(transition , "animation_finished")
	
	loaderRef = ResourceLoader.load_interactive(sceneLoad)
	
	set_process(true)
