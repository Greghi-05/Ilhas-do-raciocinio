extends Area2D

@export_enum(
	"apenas_porco", 
	"tem_chapeu", 
	"tem_oculos",
	"nao_aceita_oculos",
	"nao_aceita_verde",
	"nao_aceita_felinos"
) var regra_do_caminho: String = "apenas_porco"

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
	#REGRAS DA ILHA 1 
	if regra_do_caminho == "apenas_porco" and body.especie == "porco":
		return true
	elif regra_do_caminho == "tem_chapeu" and body.usa_chapeu == true:
		return true
	elif regra_do_caminho == "tem_oculos" and body.usa_oculos == true:
		return true
	#REGRAS DA ILHA 2
	elif regra_do_caminho == "nao_aceita_oculos":
		if body.usa_oculos == true:
			return false 
		else:
			return true  
	elif regra_do_caminho == "nao_aceita_verde":
		var tem_item_verde = false
		if body.usa_oculos and body.cor_oculos == "verde": tem_item_verde = true
		if body.usa_sapato and body.cor_sapato == "verde": tem_item_verde = true
		if body.usa_chapeu and body.cor_chapeu == "verde": tem_item_verde = true
		if tem_item_verde:
			return false 
		else:
			return true 
	elif regra_do_caminho == "nao_aceita_felinos":
		if body.especie == "gato":
			return false 
		else:
			return true  
	return false 

func entrar_na_fila() -> Vector2:
	var posicao_final = $Marker2D.global_position + (espacamento_fila * quantidade_na_fila)
	quantidade_na_fila += 1
	return posicao_final
