class_name Caminho
extends Node3D

func pegar_proximo(ponto: Marker3D) -> Marker3D:
	var idx = ponto.get_index()
	if idx >= get_child_count():
		idx = 0
	else:
		idx += 1
	
	return get_children()[idx]
