extends Control

# Puxe os nós corretos arrastando da árvore segurando Ctrl, ou ajuste os nomes
@onready var titulo_vitoria = $VBoxContainer/Label 
@onready var botao_jogar = $VBoxContainer/Button

func _ready():
	var tempo_em_segundos = Monitoramento.finalizar_jogo_e_salvar()
	
	var minutos = int(tempo_em_segundos) / 60
	var segundos = int(tempo_em_segundos) % 60
	
	var texto_final = "Parabéns, você terminou o jogo!\nSeu tempo foi de %02d:%02d yey!" % [minutos, segundos]
	titulo_vitoria.text = texto_final
	
	botao_jogar.pressed.connect(_reiniciar_jogo)

func _reiniciar_jogo():
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
