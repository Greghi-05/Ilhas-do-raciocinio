extends Control
@onready var botao_play = $VBoxContainer/Button

func _ready():
	botao_play.pressed.connect(_on_botao_play_pressed)

func _on_botao_play_pressed():
	# INICIA O MONITORAMENTO AQUI
	Monitoramento.iniciar_jogo()
	
	get_tree().change_scene_to_file("res://scenes/level 1.tscn")
