extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	owner.gravity = 1500
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector2.ZERO
	owner.cancely = 0
	owner.double_jump = 0
	owner.walljump = false
	owner.can_dash = true
	owner.animation.play("Idle")
	owner.animationk.play("empty")  

func update(_delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not owner.is_on_floor():
		%state_machine.transition_to("Air")
		return
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		%state_machine.transition_to("Dash")

	if Input.is_action_just_pressed("jump"):
		owner.animation.play("Jump")
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		%state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		%state_machine.transition_to("Run")
	
	if Input.is_action_just_released("jump") and owner.velocity.y < 0:
		owner.velocity.y = owner.mini_jump
	if Input.is_action_just_pressed("jump") and owner.is_on_floor():
		owner.velocity.y = owner.JUMP_VELOCITY
	
	if Input.is_action_just_pressed("attack"): 
		%state_machine.transition_to("attack")

