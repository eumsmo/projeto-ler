extends CharacterBody3D


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

var reset_acc_power : float = 0
var reset_max_acc : float = 0

var kart_velocity : Vector3 = Vector3.ZERO
var mouse_sensitivity : float = 0.2


func _ready():
	reset_acc_power = acc_power
	reset_max_acc = max_acc
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta):
	get_input(delta)
#	animate()
	
	if is_moving():
		var look_direction = Vector2(velocity.z, velocity.x)
		$Image.rotation.y = lerp_angle($Image.rotation.y, look_direction.angle(), delta * 12)
		$CameraPivot.rotation.x = lerp_angle($CameraPivot.rotation.x, deg_to_rad(0), delta*0.4)

	else:
		acc = 0
	
	velocity.y -= gravity*delta
	
	if is_on_floor():
		velocity.y = clamp(velocity.y, -gravity_on_floor, 10)
	else:
		velocity.y = clamp(velocity.y, -gravity, 10)
		


func get_input(delta):
	var curva = Input.get_axis("direita", "esquerda")
	var aceleracao = Input.get_axis("baixo", "cima")
	
	if aceleracao > 0:
		acc += acc_power * delta
	elif aceleracao < 0:
		acc -= acc_power * 2 * delta
	
	
	acc -= acc_power * delta * 0.25 * sign(acc)
	acc = clamp(acc, -max_acc/2, max_acc)
	
	var move_direction := Vector3.ZERO
	rotacao_vel += acc_rot * curva * delta
	rotacao_vel -= sign(rotacao_vel) * acc_rot/2 * delta
	rotacao_vel = clamp(abs(rotacao_vel), 0, max_vel_rot) * sign(rotacao_vel)
	
	rotate(Vector3.UP, (acc/max_acc) * rotacao_vel * delta)
	
	move_direction = basis.z
	velocity = Vector3(move_direction.x * move_speed * acc, velocity.y, move_direction.z * move_speed * acc)
	
	move_and_slide()


func is_moving():
	return abs(velocity.z) > 0 || abs(velocity.x) > 0


#func animate():
	#if is_on_floor():
		#if is_moving():
			#$Model/AnimationPlayer.play("run-loop")
		#else:
			#$Model/AnimationPlayer.play("idle-loop")
	#else:
		#if velocity.y < 0: #Fall
			#$Model/AnimationPlayer.play("fall-loop",0.1)
		#elif velocity.y > 0 and jump == double_jump:
			#$Model/AnimationPlayer.play("jump")
		#else:
			#$Model/AnimationPlayer.play("doublejump")
