extends Node2D

var score = 0
var picos_izquierda = []
var picos_derecha = []

func _ready():
	update_score()
	obtener_picos()
	debug_nodos()
func obtener_picos():
	# Llenar las listas con los picos según su nombre
	for i in range(1, 20):  # Picos de la izquierda (1 al 19)
		picos_izquierda.append(get_node("Pico" + str(i)))
	for i in range(20, 41):  # Picos de la derecha (20 al 40)
		picos_derecha.append(get_node("Pico" + str(i)))
func debug_nodos():
	for nodo in get_tree().get_root().get_children():
		print("📌 Nodo encontrado en root: " + nodo.name)

func add_score():
	score += 1
	update_score()
	activar_pico_random()

func update_score():
	$ScoreLabel.text = "Puntos: " + str(score)

func activar_pico_random():
	if $Jugador.position.x <= 0 or position.x >= 643:
		 # Si el jugador está en la izquierda, activamos un pico de la derecha
		var pico = picos_derecha[randi() % picos_derecha.size()]
		pico.show()
	else:
		# Si el jugador está en la derecha, activamos un pico de la izquierda
		var pico = picos_izquierda[randi() % picos_izquierda.size()]
		pico.show()

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
