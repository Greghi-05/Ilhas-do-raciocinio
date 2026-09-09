extends Node2D

@export var personagens_necessarios: int = 15 
@export var proxima_fase: String = "res://scenes/level_2.tscn" 

@onready var aviso_botao = $CanvasLayer/AvisoB
@onready var caixa_enigma = $CanvasLayer/CaixaEnigma

var personagens_resolvidos: int = 0
var estado_tela: int = 0 

func _ready():
	if aviso_botao and caixa_enigma:
		aviso_botao.visible = true
		caixa_enigma.visible = false
		caixa_enigma.modulate.a = 0.0
		caixa_enigma.scale = Vector2(0.8, 0.8)

func _input(event):
	if event is InputEventKey and event.keycode == KEY_B and event.pressed:
		
		if estado_tela == 0:
			aviso_botao.visible = false
			caixa_enigma.visible = true
			
			var tween = create_tween().set_parallel(true)
			tween.tween_property(caixa_enigma, "modulate:a", 1.0, 0.3) # Aparece em 0.3 segundos
			tween.tween_property(caixa_enigma, "scale", Vector2(1.0, 1.0), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			
			estado_tela = 1
			
		elif estado_tela == 1:
			var tween = create_tween().set_parallel(true)
			tween.tween_property(caixa_enigma, "modulate:a", 0.0, 0.2)
			tween.tween_property(caixa_enigma, "scale", Vector2(0.8, 0.8), 0.2)
			
			await tween.finished
			caixa_enigma.visible = false
			estado_tela = 2

func registrar_acerto():
	personagens_resolvidos += 1
	
	if personagens_resolvidos >= personagens_necessarios:
		print("Fase concluída! Trocando de cena...")
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file(proxima_fase)
