extends Node

var erros_totais: int = 0
var erros_por_fase: Dictionary = {} 
var tempos_por_fase: Dictionary = {} 

var tempo_inicio: int = 0
var tempo_inicio_fase: int = 0 

var escolha_fase8: String = "Nenhuma"

func iniciar_jogo():
	erros_totais = 0
	erros_por_fase.clear()
	tempos_por_fase.clear() 
	escolha_fase8 = "Nenhuma"
	
	var agora = Time.get_ticks_msec()
	tempo_inicio = agora
	tempo_inicio_fase = agora 
	print("Monitoramento iniciado!")

func fechar_tempo_fase_atual():
	var nome_fase = get_tree().current_scene.name
	var tempo_agora = Time.get_ticks_msec()
	var tempo_decorrido = (tempo_agora - tempo_inicio_fase) / 1000.0
	
	tempos_por_fase[nome_fase] = tempo_decorrido
	tempo_inicio_fase = tempo_agora 
	print("Tempo da ", nome_fase, " registrado: ", tempo_decorrido, "s")

func registrar_erro():
	erros_totais += 1
	var nome_fase = get_tree().current_scene.name
	if not erros_por_fase.has(nome_fase):
		erros_por_fase[nome_fase] = 0
	erros_por_fase[nome_fase] += 1

func registrar_escolha(escolha: String):
	escolha_fase8 = escolha

func finalizar_jogo_e_salvar() -> float:
	var tempo_fim = Time.get_ticks_msec()
	var tempo_total_segundos = (tempo_fim - tempo_inicio) / 1000.0
	_gerar_csv(tempo_total_segundos)
	return tempo_total_segundos

func _gerar_csv(tempo_total: float):
	var caminho_desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	var caminho = caminho_desktop + "/dados_estudantes.csv"
	var arquivo
	
	if not FileAccess.file_exists(caminho):
		arquivo = FileAccess.open(caminho, FileAccess.WRITE)
		# NOVA COLUNA: Tempos_Detalhados
		arquivo.store_line("Data_Hora,Tempo_Segundos,Erros_Totais,Erros_Detalhados,Tempos_Detalhados,Escolha_Fase_Final")
	else:
		arquivo = FileAccess.open(caminho, FileAccess.READ_WRITE)
		arquivo.seek_end()
	
	var data_hora = Time.get_datetime_string_from_system()
	
	var texto_erros = ""
	for fase in erros_por_fase:
		texto_erros += fase + ": " + str(erros_por_fase[fase]) + " | "
	if texto_erros == "": texto_erros = "Nenhum erro"
	else: texto_erros = texto_erros.trim_suffix(" | ")
		
	var texto_tempos = ""
	for fase in tempos_por_fase:
		texto_tempos += fase + ": " + str(tempos_por_fase[fase]).pad_decimals(1) + "s | "
	if texto_tempos == "": texto_tempos = "Sem dados"
	else: texto_tempos = texto_tempos.trim_suffix(" | ")
	
	var linha = data_hora + "," + str(tempo_total).pad_decimals(2) + "," + str(erros_totais) + "," + texto_erros + "," + texto_tempos + "," + escolha_fase8
	
	arquivo.store_line(linha)
	arquivo.close()
