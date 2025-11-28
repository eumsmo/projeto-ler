extends CharacterBody3D

@export var idx:= 0
var target : Vector3

@export var point_radius := 1.0
@export var velocidade := 1.0



@export var move_speed : float = 5 #Default 4
@export var gravity_clamp : float = 9.8 #Default 9.8
@export var gravity : float = 5 #Default 5
@export var gravity_on_floor : float = 2.5 #Default 2.5


@export_group("Aceleração")
@export var acc : float = 0.0 #Initial Value
@export var max_acc : float = 4.0
@export var acc_power : float = 5.5 #Incremental Value

@export var acc_rot := 12.0
@export var max_vel_rot := 3.0
var rotacao_vel := 0.0


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
	
	print(str(dir))
	
	var aceleracao = -dir.x
	
	
	if aceleracao > 0:
		acc += acc_power * delta
	elif aceleracao < 0:
		acc -= acc_power * 2 * delta
	
	
	acc -= acc_power * delta * 0.25
	acc = clamp(acc, -max_acc/2, max_acc)
	
	var move_direction := Vector3.ZERO
	
	move_direction = lerp(move_direction, dir, 0.9).normalized()
	move_direction.y = 0
	velocity = move_direction * abs(move_speed * acc)
	
	move_and_slide()
	
