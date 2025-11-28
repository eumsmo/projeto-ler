class_name Pista
extends Node3D

@export var voltas := 3

@export_category("Referências")
@export var caminho: Node3D

func pegar_pedaco(idx: int) -> Node3D:
	return caminho.get_child(idx)

func pedaco_quant() -> int:
	return caminho.get_child_count()
