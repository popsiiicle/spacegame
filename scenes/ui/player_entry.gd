class_name PlayerEntry extends HBoxContainer


@onready var playername: Label = $PlayerName
@onready var kills: Label = $Kills
@onready var deaths: Label = $Deaths



static func create(playerlist: VBoxContainer, entrydict: Dictionary):
	var newentry = preload("res://scenes/ui/player_entry.tscn").instantiate()
	playerlist.add_child(newentry)
	newentry.playername.text = entrydict["name"]
	newentry.kills.text = str(entrydict["kills"])
	newentry.deaths.text = str(entrydict["deaths"])
