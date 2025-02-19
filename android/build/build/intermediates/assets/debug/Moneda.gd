extends Node2D

signal moneda_recogida  # Señal para avisar cuando se toma la moneda

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Jugador"):  # Si el jugador la toca
		moneda_recogida.emit()  # Enviar señal de que se recogió
		Global.monedaspartida += 1
		queue_free()  # Eliminar la moneda
