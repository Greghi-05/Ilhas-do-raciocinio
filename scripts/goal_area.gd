extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.color == "blue":
		print(body.character_name, "PASSOU")
	else:
		print(body.character_name, "BLOQUEADO")
