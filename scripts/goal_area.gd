extends Area2D

@export_enum("apenas_porco", "tem_acessorio", "tem_oculos") var regra_do_caminho: String = "apenas_porco"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if "especie" in body:
		var passou = false
		if regra_do_caminho == "apenas_porco" and body.especie == "porco":
			passou = true
		elif regra_do_caminho == "tem_acessorio" and body.usa_acessorio_cabeca == true:
			passou = true
		elif regra_do_caminho == "tem_oculos" and body.usa_oculos == true:
			passou = true
			
		if passou:
			print("PASSOU!")
		else:
			print("BLOQUEADO!")
