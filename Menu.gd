extends Node

func _ready():
	$Moneda/CantidadMonedas.text = str(Global.monedas)
	$Highscore.text = "Highscore: " + str(Global.highscore)
	print(Global.highscore)
	
func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Juego.tscn")


func _on_tienda_pressed():
	get_tree().change_scene_to_file("res://Tienda.tscn")
