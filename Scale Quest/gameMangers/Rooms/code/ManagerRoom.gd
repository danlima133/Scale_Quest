extends Node

enum LevelRoom {
	Major_Plain
	Whole_Tone_Woods
	Gypys_Major_Desert
	Minor_Volcano
}

export(LevelRoom) var roomType
export(int , 1 , 100) var roomNumber
export(int) var roomID
