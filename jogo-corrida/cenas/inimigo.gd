extends CharacterBody3D

@export var idx:= 0
var target : Vector3

@export var point_radius := 1.0
@export var velocidade := 1.0

@export_category("Referências")
@export var caminho: Path3D
@export var navegacao: NavigationAgent3D

const SPEED = 5.0


func _ready() -> void:
	ir_para(idx)

func ir_para(index: int):
	idx = index
	target = caminho.curve.get_point_position(idx)
	navegacao.target_position = target

func _physics_process(delta: float) -> void:
	var dist = position.distance_to(target)
	if dist <= point_radius:
		ir_para((idx+1) % caminho.curve.point_count)
	
	
	var dest = navegacao.get_next_path_position()
	var local_dest = dest - global_position
	var dir = local_dest.normalized()
	
	velocity = dir * velocidade
	move_and_slide()
	
