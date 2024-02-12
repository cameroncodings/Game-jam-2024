extends State


func enter(msg := {}) -> void:
	owner.gravity = 1500
	if msg.has("do_jump"):
		owner.velocity.y = -owner.JUMP_VELOCITY
		owner.double_jump = 0


func physics_update(delta: float) -> void:
	# Horizontal movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		owner.velocity.x = direction * owner.SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)

	owner.move_and_slide()
	# Vertical movement.
	owner.velocity.y += owner.gravity * delta
	owner.move_and_slide()

	# Landing.
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			%state_machine.transition_to("Idle")
		else:
			%state_machine.transition_to("Run")
	
	if Input.is_action_just_pressed("ground_pound") and not owner.is_on_floor():
		%state_machine.transition_to("Ground_pound")
	
	if Input.is_action_just_pressed("jump") and owner.double_jump == 0 and not owner.is_on_wall():
		owner.velocity.y = owner.DOUBLE_JUMP
		owner.double_jump = 1
	 
	print(owner.is_on_wall())
	if owner.is_on_wall() and Input.is_action_just_pressed("jump"):
		owner.velocity.y = owner.JUMP_VELOCITY
		owner.velocity.x = 0
	
