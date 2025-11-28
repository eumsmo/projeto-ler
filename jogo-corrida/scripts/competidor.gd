class_name Competidor
extends CharacterBody3D

@export var pista: Pista
var ponto_atual = -1
var volta_atual = 0

signal atingiu_parte(parte: int)
signal marcou_volta(parte: int)

func _init() -> void:
	marcar_volta()

func marcar_caminho(parte: int) -> void:
	if ponto_atual == -1 or ponto_atual + 1 == parte:
		ponto_atual = parte
		atingiu_parte.emit(parte)
	elif ponto_atual == pista.pedaco_quant() -1 and parte == 0:
		marcar_volta()

func marcar_volta() -> void:
	ponto_atual = 0
	volta_atual += 1
	
	atingiu_parte.emit(0)
	marcou_volta.emit(volta_atual)
