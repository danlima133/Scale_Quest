extends Node

export(NodePath) var refNoteMusicalPath
export(NodePath) var refReciveDataPath

export(String , FILE , "*.MGconfig") var configNoteMusicalPath

var configSchemeData:Dictionary

var NoteMusical:Object
var ReciveData:Object

var active = false

func _get_config():
	
	var file = File.new()
	
	if file.file_exists(configNoteMusicalPath):
		
		var erro = file.open(configNoteMusicalPath , File.READ)
		
		if erro == OK:
			
			var jsonText = file.get_as_text()
			
			configSchemeData = parse_json(jsonText) 
			
			_get_objects()

func _get_objects():
	
	NoteMusical = get_node(refNoteMusicalPath)
	
	ReciveData = get_node(refReciveDataPath)

func _sync_with_other_objects():
	
	pass

func _callByCase(key:String):
	
	var objetcPaths = configSchemeData.keys()
	
	for objP in objetcPaths:
		
		var obj = ReciveData.get_node(objP)
		
		var arrayMethods:Array = configSchemeData[objP][key]
		
		for call in arrayMethods:
			
			print(call)
			
			obj.call(call)

func callObjects(case:bool):
	
	active = case
	
	match case:
		
		true:
			
			_callByCase("active")
		
		false:
			
			_callByCase("desactive")

func _ready():
	
	_get_config()
