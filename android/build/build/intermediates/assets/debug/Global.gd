extends Node

var monedas = 0
var monedaspartida = 0
var highscore = 0


func _ready():
	monedas = Save.loadValue("Menu", "monedas", 0)
	highscore = Save.loadValue("Menu", "highscore", 0)
