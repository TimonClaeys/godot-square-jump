extends KinematicBody2D

export var max_speed := 10000
export var acceleration := 300.0
export var deceleration := 300.0

export var jump_strength := 100.0

var horizontal_direction := 0

var is_jumping := false

var speed := 0.0
var velocity = Vector2.ZERO

var gravity = 100.0

func _physics_process(delta: float) -> void:
	change_speed()
	change_velocity(delta)
	
	if is_jumping and is_on_floor():
		jump(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	print(velocity)
	
	is_jumping = false


func _input(event: InputEvent) -> void:
	horizontal_direction = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	if Input.is_action_just_pressed("jump"):
		
		is_jumping = true

func change_speed() -> void:
	if horizontal_direction != 0:
		speed += acceleration
	else:
		speed -= deceleration
	speed = clamp(speed, 0, max_speed)


func change_velocity(delta: float) -> void:
	velocity.x = horizontal_direction * speed * delta
	velocity.y += gravity * delta


func jump(delta: float) -> void:
	velocity.y -= jump_strength
