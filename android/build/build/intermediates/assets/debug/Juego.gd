extends Node2D

var score = 0
var moneda_presente = false
var moneda_escena = preload("res://Moneda.tscn")
var picos_izquierda = []
var picos_derecha = []
var ultimo_pico_izquierda = null
var ultimo_pico_derecha = null

func _ready():
	Global.monedaspartida = 0
	update_score()
	obtener_picos()

func obtener_picos():
	for i in range(1, 20):  # Picos de la izquierda (1 al 19)
		var pico = get_node_or_null("Pico" + str(i))
		if pico:
			picos_izquierda.append(pico)
			print("✅ Encontrado: Pico" + str(i))
		else:
			print("❌ ERROR: No se encontró Pico" + str(i))

	for i in range(20, 41):  # Picos de la derecha (20 al 40)
		var pico = get_node_or_null("Pico" + str(i))
		if pico:
			picos_derecha.append(pico)
			print("✅ Encontrado: Pico" + str(i))
		else:
			print("❌ ERROR: No se encontró Pico" + str(i))


func add_score():
	score += 1
	update_score()
	activar_pico_random()
	if score % 2 == 0 and not moneda_presente:
		generar_moneda()
func update_score():
	$ScoreLabel.text = str(score)
func generar_moneda():
	var moneda = moneda_escena.instantiate()
	moneda.position = Vector2(randf_range(256, 512), randf_range(128, 1152))  # Área donde puede aparecer
	moneda.connect("moneda_recogida", Callable(self, "_on_moneda_recogida"))
	add_child(moneda)
	moneda_presente = true
func _on_moneda_recogida():
	moneda_presente = false
	print("✅ La moneda fue recogida y se puede generar una nueva.")  # Para depuración
func activar_pico_random():
	# Asegurar que los picos de ambos lados se oculten antes de activar uno nuevo
	var lista_picos = []
	var ultimo_pico = null

	# Determinar qué lista de picos usar y cuál fue el último activado
	if $Jugador.position.x >= 643:  # Si toca el borde derecho, activamos un pico en la izquierda
		lista_picos = picos_izquierda
		ultimo_pico = ultimo_pico_izquierda
	elif $Jugador.position.x <= 0:  # Si toca el borde izquierdo, activamos un pico en la derecha
		lista_picos = picos_derecha
		ultimo_pico = ultimo_pico_derecha

	# Filtrar solo los picos que NO estén activados
	var picos_disponibles = []
	for pico in lista_picos:
		if pico and not pico.visible and pico != ultimo_pico:  # Evitar el último pico activado
			picos_disponibles.append(pico)

	# Verificar si hay picos disponibles antes de seleccionar uno
	if picos_disponibles.size() > 0:
		var pico_elegido = picos_disponibles[randi() % picos_disponibles.size()]
		pico_elegido.show()
		print(pico_elegido)
		# Guardar el último pico activado para evitar repeticiones
		if lista_picos == picos_izquierda:
			ultimo_pico_izquierda = pico_elegido
		else:
			ultimo_pico_derecha = pico_elegido

	else:
		print("⚠️ No se encontró un pico nuevo. Se intentará reiniciar.")


func on_game_over():
	print(Global.monedaspartida)
	newhighscore()
	$MenuFinal.show()
	get_tree().paused = true  # Pausa el juego
	print("Skeree")
	
	
func _on_death_zone_body_entered(body):
	if body.name == "Jugador":  # Asegúrate de que es el jugador
		on_game_over()
func newhighscore():
	print("Hola")
	if score >= Global.highscore:
		print("si")
		Global.highscore = score
		Save.saveValue("Menu", "highscore", Global.highscore)
