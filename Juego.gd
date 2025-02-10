extends Node2D
var score = 0 # Puntuación del jugador

func _ready():
	update_score()  # Actualizar la puntuación al inicio
func add_score():
	score += 1  # Aumentar puntuación
	update_score()  # Reflejar el cambio en pantalla
func update_score():
	$ScoreLabel.text = str(score)  # Actualizar el texto en pantalla

func _on_reinicio_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu.tscn")

func on_game_over():
	$MenuPartida.visible = true
	get_tree().paused = true  # Pausa el juego
	
func _on_death_zone_body_entered(body):
	if body.name == "Jugador":  # Asegúrate de que es el jugador
		on_game_over()
