extends CharacterBody3D


var SPEED = 10
const JUMP_VELOCITY = 4.5
@onready var node_3d_2: Node3D = $Node3D2







func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	
	var input_dir_god := Input.get_axis("ui_page_down","ui_page_up")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if Input.is_key_pressed(KEY_A):
		node_3d_2.rotation.y +=.1
	
	if Input.is_key_pressed(KEY_D):
		node_3d_2.rotation.y -=.1
	
	if Input.is_key_pressed(KEY_CTRL):
		SPEED = 100
	else: 
		SPEED = 10
	
	
	if input_dir_god:
		velocity.y = input_dir_god * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
