extends Popup

onready var name_level = $panel/content/name_level

onready var div_1 = $panel/content/div_1
onready var div_2 = $panel/content/div_2

var popupRef:Dictionary

func get_ref(refName:String):
	
	popupRef["nameLevel"] = refName
	
	popupRef["roomCount"] = MangerLevel.get_roomsCount_byLevel(refName)
	
	popupRef["avarageTimeLevel"] = MangerLevel.levelsTimeReal[refName]
	
	_setData()

func _setData():
	
	name_level.text = popupRef.nameLevel.replace("_" , " ")
	
	div_1.get_node("count").text = str(popupRef.roomCount)
	
	div_2.get_node("count").text = str(popupRef.avarageTimeLevel)

func _on_levelPop_up_popup_hide():
	
	queue_free()
