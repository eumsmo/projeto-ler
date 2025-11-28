extends Node3D

@export var pista: Pista
@export var jogador: Competidor
@export var inimigos: Array[Competidor]

@export_category("Interface")
@export var quantidade_voltas_txt: Label
@export var quantidade_checkpoints_txt: Label


func _ready() -> void:
	jogador.pista = pista
	for inimigo in inimigos:
		inimigo.pista = pista
	
	jogador.atingiu_parte.connect(ao_atingir_parte)
	jogador.marcou_volta.connect(ao_deu_volta)
	
	ao_atingir_parte(jogador.ponto_atual)
	ao_deu_volta(jogador.volta_atual)
	

func ao_atingir_parte(parte) -> void:
	quantidade_checkpoints_txt.text = str(parte + 1) + "/" + str(pista.pedaco_quant())

func ao_deu_volta(volta) -> void:
	quantidade_voltas_txt.text = str(volta) + "/" + str(pista.voltas)
