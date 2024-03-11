extends State

func enter(_msg := {}) -> void:
	owner.gravity = 200
	owner.animation.play("Ground_pound")
	$"../../groundpound/poundbox".disabled = false

func physics_update(_delta: float) -> void:
	
	# Horizontal movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		owner.velocity.x = direction * owner.SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)

	# Vertical movement.
	owner.velocity.y += owner.gravity


	# Landing.
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			$"../../groundpound/poundbox".disabled = true
			%state_machine.transition_to("Idle")
		else:
			$"../../groundpound/poundbox".disabled = true
			%state_machine.transition_to("Run")
		
	if Input.is_action_just_pressed("jump") and owner.cancely == 0:
		$"../../groundpound/poundbox".disabled = true
		owner.velocity.y = owner.DOUBLE_JUMP
		owner.cancely = 1
		%state_machine.transition_to("Air")
		
		


func _on_groundpound_area_entered(area):
	if area.name == "Death" or area.name == "Win":
		pass
	else:
		owner.velocity.y = owner.DOUBLE_JUMP
		owner.cancely = 1
		%state_machine.transition_to("Air")
