extends CharacterBody2D
# Velocidad del jugador
var speed = 300

# Dirección inicial
var direction = Vector2.RIGHT

func _physics_process(delta):
	# Mover al jugador
	velocity = direction * speed
	move_and_slide()

	# Detectar si toca los bordes
	if position.x <= 0 or position.x >= get_viewport_rect().size.x:
		reverse_direction()

func reverse_direction():
	# Cambiar la dirección horizontal
	direction.x *= -1
