extends CharacterBody2D

@export_enum("porco", "gato", "vaca", "sapo", "urso", "pinto") var especie: String = "porco"
@export var usa_oculos: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_oculos: String = "nenhuma"
@export var usa_sapato: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_sapato: String = "nenhuma"
@export var usa_chapeu: bool = false
@export_enum("nenhuma", "azul", "vermelho", "verde", "amarelo", "roxo") var cor_chapeu: String = "nenhuma"

var esta_arrastando: bool = false
var diferenca_mouse: Vector2 = Vector2.ZERO
var posicao_inicial: Vector2 
var caminho_atual = null 
var foi_resolvido: bool = false 

func _ready():
	posicao_inicial = global_position

func _input_event(viewport, event, shape_idx):
	if foi_resolvido: return 
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed: 
			esta_arrastando = true
			diferenca_mouse = global_position - get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and esta_arrastando:
			esta_arrastando = false
			
			if caminho_atual != null:
				if caminho_atual.validar_personagem(self) == true:
					global_position = caminho_atual.entrar_na_fila()
					foi_resolvido = true 
					print(especie, " passou no caminho e entrou na fila!")
				else:
					global_position = posicao_inicial
					print(especie, " foi rejeitado!")
			else:
				global_position = posicao_inicial

func _physics_process(delta):
	if esta_arrastando:
		global_position = get_global_mouse_position() + diferenca_mouse
