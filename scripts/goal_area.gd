extends Area2D

@export_enum("apenas_porco", "tem_acessorio", "tem_oculos") var regra_do_caminho: String = "apenas_porco"

@export var espacamento_fila: Vector2 = Vector2(60, 0) 
var quantidade_na_fila: int = 0 

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if "caminho_atual" in body:
		body.caminho_atual = self 

func _on_body_exited(body):
	if "caminho_atual" in body and body.caminho_atual == self:
		body.caminho_atual = null 

func validar_personagem(body) -> bool:
	if regra_do_caminho == "apenas_porco" and body.especie == "porco":
		return true
	elif regra_do_caminho == "tem_acessorio" and body.usa_acessorio_cabeca == true:
		return true
	elif regra_do_caminho == "tem_oculos" and body.usa_oculos == true:
		return true
	return false 

func entrar_na_fila() -> Vector2:
	var posicao_final = global_position + (espacamento_fila * quantidade_na_fila)
	quantidade_na_fila += 1
	return posicao_final
