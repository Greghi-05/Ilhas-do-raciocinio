extends Control

# Puxa os 3 botões (ajuste os nomes se você colocou diferente)
@onready var btn_fase9 = $"VBoxContainer/HBoxContainer/Fase das regras"
@onready var btn_fase10 = $"VBoxContainer/HBoxContainer/Fase do espelho"
@onready var btn_fase11 = $"VBoxContainer/HBoxContainer/Fase do impostor"

func _ready():
	# Conecta cada botão à sua respectiva fase
	btn_fase9.pressed.connect(_ir_para_fase9)
	btn_fase10.pressed.connect(_ir_para_fase10)
	btn_fase11.pressed.connect(_ir_para_fase11)

func _ir_para_fase9():
	Monitoramento.registrar_escolha("Regras Ocultas")
	get_tree().change_scene_to_file("res://scenes/level 9.tscn") # Ajuste o caminho

func _ir_para_fase10():
	Monitoramento.registrar_escolha("Espelho")
	get_tree().change_scene_to_file("res://scenes/level 10.tscn") # Ajuste o caminho

func _ir_para_fase11():
	Monitoramento.registrar_escolha("Impostor")
	get_tree().change_scene_to_file("res://scenes/level 11.tscn") # Ajuste o caminho
