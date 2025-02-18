extends CharacterBody2D
# Velocidad del jugador
# Configuración del movimiento
@export var gravity = 800         # Fuerza de gravedad
@export var jump_force = -400     # Fuerza de salto
@export var max_fall_speed = 600  # Velocidad máxima de caída
@export var speed = 300           # Velocidad horizontal

# Dirección inicial
var direction = Vector2.RIGHT
# Referencia a la escena del juego
var juego = null

func _ready():
	juego = get_parent()  # Guarda referencia al nodo 'Juego'
func _physics_process(delta):
	# Aplicar gravedad al jugador
	if velocity.y < max_fall_speed:
		velocity.y += gravity * delta

	# Movimiento horizontal
	velocity.x = direction.x * speed

	# Mover al jugador
	move_and_slide()

	# Detectar si toca los bordes de la pantalla
	if position.x <= -15 or position.x >= 658:
		reverse_direction()

func reverse_direction():
	# Cambiar la dirección horizontal
	direction.x *= -1
	$SpriteJugador.scale.x *= -1
	if juego:
		juego.add_score() 
func _input(event):
	# Detectar si el jugador toca la pantalla
	if event is InputEventScreenTouch and event.pressed:
		jump()

func jump():
	# Aplicar fuerza de salto
	velocity.y = jump_force

func end():
	if position.y == 0:
		$"../Panel".show

func _on_tap_pressed():
	jump()
func on_game_over():
	$"../MenuPartida".visible = true
	get_tree().paused = true  # Pausa el juego
