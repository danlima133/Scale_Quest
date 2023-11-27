extends Node2D

func creditConclused():
	
	$"%Credits".play("finishedCredit")
	
	yield($"%Credits" , "animation_finished")
	
	$"%Execute".active = false
	
	$"%Credits".play("normal")
