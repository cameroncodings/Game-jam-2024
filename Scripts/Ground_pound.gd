extends State


func enter(msg := {}) -> void:
	owner.gravity = 10000


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
		
	if Input.is_action_just_pressed("jump"):
		owner.velocity.y = owner.JUMP_VELOCITY
		%state_machine.transition_to("Air")