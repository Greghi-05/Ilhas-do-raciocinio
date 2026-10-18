extends Area2D

@export_enum(
	# ILHA 1
	"apenas_porco", 
	"tem_chapeu", 
	"tem_oculos",
	# ILHA 2 
	"nao_aceita_oculos",
	"nao_aceita_verde",
	"nao_aceita_felinos",
	# ILHA 3
	"bota_especifica_sem_chapeu",
	"qualquer_chapeu_sem_bota",
	"chapeu_restrito_com_bota",
	# ILHA 4
	"vermelho_e_bota",
	# ILHA 5
	"ou_exclusivo_bota_chapeu",
	# ILHA 6
	"ilha6_espelho",
	# ILHA 7
	"impostor_azul",
	# DESAFIOS FINAIS (ILHA 8)
	"desafio_final_xor_gato_oculos",
	"desafio_final_espelho_trocado",
	"desafio_final_impostor_oculos"
) var regra_do_caminho: String = "apenas_porco"

@export var personagem_referencia: Node2D 

@export var espacamento_fila: Vector2 = Vector2(60, 0) 
var quantidade_na_fila: int = 0 

var arquivo_som_falha = preload("res://sounds/sound effects/fail sound.wav") 
var tocador_de_som: AudioStreamPlayer2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	tocador_de_som = AudioStreamPlayer2D.new()
	tocador_de_som.stream = arquivo_som_falha
	tocador_de_som.volume_db = -20.0
	add_child(tocador_de_som)

func _on_body_entered(body):
	if "caminho_atual" in body:
		body.caminho_atual = self 

func _on_body_exited(body):
	if "caminho_atual" in body and body.caminho_atual == self:
		body.caminho_atual = null 

func validar_personagem(body) -> bool:
	var resultado: bool = false

	# REGRAS DA ILHA 1
	if regra_do_caminho == "apenas_porco" and body.especie == "porco":
		resultado = true
	elif regra_do_caminho == "tem_chapeu" and body.usa_chapeu == true:
		resultado = true
	elif regra_do_caminho == "tem_oculos" and body.usa_oculos == true:
		resultado = true
		
	# REGRAS DA ILHA 2
	elif regra_do_caminho == "nao_aceita_oculos":
		if body.usa_oculos == true:
			resultado = false 
		else:
			resultado = true  
			
	elif regra_do_caminho == "nao_aceita_verde":
		var tem_item_verde = false
		if body.usa_oculos and body.cor_oculos == "verde": tem_item_verde = true
		if body.usa_sapato and body.cor_sapato == "verde": tem_item_verde = true
		if body.usa_chapeu and body.cor_chapeu == "verde": tem_item_verde = true
		
		if tem_item_verde:
			resultado = false 
		else:
			resultado = true  
			
	elif regra_do_caminho == "nao_aceita_felinos":
		if body.especie == "gato":
			resultado = false 
		else:
			resultado = true  

	# REGRAS DA ILHA 3  
	elif regra_do_caminho == "bota_especifica_sem_chapeu":
		if body.usa_sapato == true and body.cor_sapato != "verde" and body.cor_sapato != "azul" and body.usa_chapeu == false:
			resultado = true
		else:
			resultado = false
			
	elif regra_do_caminho == "qualquer_chapeu_sem_bota":
		if body.usa_chapeu == true and body.usa_sapato == false:
			resultado = true
		else:
			resultado = false
			
	elif regra_do_caminho == "chapeu_restrito_com_bota":
		if body.usa_chapeu == true and (body.cor_chapeu == "roxo" or body.cor_chapeu == "vermelho") and body.usa_sapato == true:
			resultado = true
		else:
			resultado = false
			
	# REGRAS DA ILHA 4
	elif regra_do_caminho == "vermelho_e_bota":
		var condicao_bota = body.usa_sapato
		var condicao_vermelho = false
		
		if (body.usa_sapato and body.cor_sapato == "vermelho"): condicao_vermelho = true
		elif (body.usa_chapeu and body.cor_chapeu == "vermelho"): condicao_vermelho = true
		elif (body.usa_oculos and body.cor_oculos == "vermelho"): condicao_vermelho = true
			
		if condicao_bota == true and condicao_vermelho == true:
			resultado = true
		else:
			resultado = false

	# REGRAS DA ILHA 5 
	elif regra_do_caminho == "ou_exclusivo_bota_chapeu":
		var tem_bota = body.usa_sapato
		var tem_chapeu = body.usa_chapeu
		if tem_bota != tem_chapeu:
			resultado = true
		else:
			resultado = false

	# REGRAS DA ILHA 6 (O Espelho Lógico)
	elif regra_do_caminho == "ilha6_espelho":
		if personagem_referencia != null:
			if personagem_referencia.usa_chapeu == true:
				if body.usa_sapato == true and body.cor_sapato == personagem_referencia.cor_chapeu:
					resultado = true
				else:
					resultado = false
			elif personagem_referencia.usa_oculos == true:
				if body.usa_chapeu == true:
					resultado = true
				else:
					resultado = false
		else:
			resultado = false
		
	# REGRAS DA ILHA 7
	elif regra_do_caminho == "impostor_azul":
		if body.usa_sapato == true and body.cor_sapato == "azul" and body.usa_chapeu == true and body.cor_chapeu == "azul":
			resultado = true
		else:
			resultado = false
			
	# DESAFIOS FINAIS (ILHA 8)
	
	# Regra 1
	elif regra_do_caminho == "desafio_final_xor_gato_oculos":
		var e_gato = (body.especie == "gato")
		var tem_oculos = body.usa_oculos
		if e_gato != tem_oculos:
			resultado = true
		else:
			resultado = false

	# Regra 2
	elif regra_do_caminho == "desafio_final_espelho_trocado":
		if personagem_referencia != null:
			if personagem_referencia.usa_sapato == true:
				if body.especie == personagem_referencia.especie and body.usa_chapeu == true and body.cor_chapeu == personagem_referencia.cor_sapato:
					resultado = true
				else:
					resultado = false
			elif personagem_referencia.usa_oculos == true:
				if body.especie == personagem_referencia.especie and body.usa_chapeu == false and body.usa_oculos == false and body.usa_sapato == false:
					resultado = true
				else:
					resultado = false
		else:
			resultado = false

	# Regra 3
	elif regra_do_caminho == "desafio_final_impostor_oculos":
		if body.usa_chapeu == true and body.usa_sapato == true and body.cor_chapeu != body.cor_sapato:
			if body.usa_oculos == true and body.cor_oculos != "azul":
				resultado = true
			else:
				resultado = false
		else:
			resultado = false
			
	if resultado == false:
		tocador_de_som.play()
		
	return resultado 

func entrar_na_fila() -> Vector2:
	var posicao_final = $Marker2D.global_position + (espacamento_fila * quantidade_na_fila)
	quantidade_na_fila += 1
	return posicao_final
