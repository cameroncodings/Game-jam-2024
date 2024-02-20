extends State

func enter(msg := {}) -> void:
	owner.gravity = 250
	owner.animation.play("Ground_pound")


func physics_update(delta: float) -> void:
	
	# Horizontal movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		owner.velocity.x = direction * owner.SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)

	owner.move_and_slide()
	# Vertical movement.
	owner.velocity.y += owner.gravity
	owner.move_and_slide()

	# Landing.
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			%state_machine.transition_to("Idle")
		else:
			%state_machine.transition_to("Run")
		
	if Input.is_action_just_pressed("jump") and owner.cancely == 0:
		owner.velocity.y = owner.JUMP_VELOCITY
		owner.cancely = 1
		%state_machine.transition_to("Air")
		
		
