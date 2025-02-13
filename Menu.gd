extends Node


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Juego.tscn")


func _on_tienda_pressed():
	get_tree().change_scene_to_file("res://Tienda.tscn")
