extends CharacterBody2D

@export_enum("porco", "gato", "vaca", "sapo", "urso", "pinto") var especie: String = "porco"

@export var usa_oculos: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_oculos: String = "nenhuma"

@export var usa_sapato: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_sapato: String = "nenhuma"

@export var usa_acessorio_cabeca: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_acessorio_cabeca: String = "nenhuma"


func _ready():
	print("--- NOVO PERSONAGEM CARREGADO ---")
	print("Espécie: ", especie)
	print("Usa óculos? ", usa_oculos, " | Cor do óculos: ", cor_oculos)
	print("Usa sapato? ", usa_sapato, " | Cor do sapato: ", cor_sapato)
	print("Usa acessório na cabeça? ", usa_acessorio_cabeca, " | Cor do acessório: ", cor_acessorio_cabeca)
	print("---------------------------------")
