extends Area2D

func _on_body_entered(body):
	if body.name == "Jugador" and self.visible:  # Solo afecta si el pico está visible
		body.on_game_over()
