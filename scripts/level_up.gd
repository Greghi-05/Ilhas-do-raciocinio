extends Node2D

@export var personagens_necessarios: int = 15

@export var proxima_fase: String = "res://scenes/level 2.tscn" 

var personagens_resolvidos: int = 0

func registrar_acerto():
	personagens_resolvidos += 1
	
	
	if personagens_resolvidos >= personagens_necessarios:
		print("Fase concluída! Trocando de cena...")
		
		await get_tree().create_timer(1.5).timeout
		
		get_tree().change_scene_to_file(proxima_fase)
