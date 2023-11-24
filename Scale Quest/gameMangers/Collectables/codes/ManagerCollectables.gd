extends Node

var keys:int

func set_key(count:int):
	
	keys += count
	
	get_tree().call_group("roomUI" , "set_keyValue" , keys)

func remove_key(count:int):
	
	keys -= count
	
	get_tree().call_group("roomUI" , "set_keyValue" , keys)
