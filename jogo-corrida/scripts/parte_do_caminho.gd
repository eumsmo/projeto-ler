extends Marker3D

@export var ordem := 0

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("competidor"):
		body.marcar_caminho(ordem)
