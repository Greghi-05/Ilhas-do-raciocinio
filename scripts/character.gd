extends CharacterBody2D

# --- ESPÉCIE ---
@export_enum("porco", "gato", "vaca", "sapo", "urso", "pinto") var especie: String = "porco"

# --- ÓCULOS ---
@export var usa_oculos: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo") var cor_oculos: String = "nenhuma"

# --- SAPATOS ---
@export var usa_sapato: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo") var cor_sapato: String = "nenhuma"

# --- ACESSÓRIO DE CABEÇA ---
@export var usa_acessorio_cabeca: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo") var cor_acessorio_cabeca: String = "nenhuma"


func _ready():
	# Imprime no console exatamente como esse personagem foi configurado no Inspector!
	print("--- NOVO PERSONAGEM CARREGADO ---")
	print("Espécie: ", especie)
	print("Usa óculos? ", usa_oculos, " | Cor do óculos: ", cor_oculos)
	print("Usa sapato? ", usa_sapato, " | Cor do sapato: ", cor_sapato)
	print("Usa acessório na cabeça? ", usa_acessorio_cabeca, " | Cor do acessório: ", cor_acessorio_cabeca)
	print("---------------------------------")


func _physics_process(delta):
	# Mantive o movimento simples que você tinha feito no seu script original
	position.x += 100 * delta
