extends State

func enter(_msg := {}) -> void:
	owner.gravity = 1500
	owner.cancely = 0

func physics_update(delta: float) -> void:
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not owner.is_on_floor():
		%state_machine.transition_to("Air")
		return

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		owner.velocity.x = direction * owner.SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)
		
	owner.move_and_slide()
	owner.velocity.y += owner.gravity * delta
	owner.move_and_slide()

	if Input.is_action_just_pressed("jump"):
		%state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(direction, 0.0):
		%state_machine.transition_to("Idle")
		%state_machine.transition_to("Air", {do_jump = true})
		
	if Input.is_action_just_pressed("jump") and owner.is_on_floor():
		owner.velocity.y = owner.JUMP_VELOCITY
	if Input.is_action_just_released("jump") and owner.velocity.y < 0:
		owner.velocity.y = owner.mini_jump

	
