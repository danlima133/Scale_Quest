extends Node

const rootDataPath = "user://DataGame.data"

func saveGame():
	
	var file = File.new()
	
	var erro = file.open(rootDataPath , File.WRITE)
	
	if erro == OK:
		
		var dataGroup = {
			"LevelsConclused":MangerLevel.levelsCompleted,
			"LevelsTimeAvarage":MangerLevel.levelsAvarageTime,
			"LevelsTimeReal":MangerLevel.levelsTimeReal,
			"CurrentLevel":MangerLevel.current_level,
			"LastPoint":MangerLevel.lastPoint,
			"ConlusedGame":MangerLevel.conlusedGame,
			"HasCutscene":Global.hasCutscene,
			"HasCredits":Global.hasCredits
		}
		
		file.store_var(dataGroup)
	
	file.close()

func loadGame():
	
	var file = File.new()
	
	var erro = file.open(rootDataPath , File.READ)
	
	if erro == OK:
		
		if file.file_exists(rootDataPath):
			
			var dataFile:Dictionary = file.get_var()
			
			_setData(dataFile)
	
	file.close()

func _setData(data:Dictionary):
	
	MangerLevel.levelsCompleted = data["LevelsConclused"]
	MangerLevel.levelsAvarageTime = data["LevelsTimeAvarage"]
	MangerLevel.levelsTimeReal = data["LevelsTimeReal"]
	MangerLevel.current_level = data["CurrentLevel"]
	MangerLevel.lastPoint = data["LastPoint"]
	MangerLevel.conlusedGame = data["ConlusedGame"]
	Global.hasCutscene = data["HasCutscene"]
	Global.hasCredits = data["HasCredits"]
	
