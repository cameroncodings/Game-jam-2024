extends State
var time = 0

func enter(msg := {}) -> void:
	owner.cantm = false
	owner.gravity = 2000
	if msg.has("do_jump"):
		owner.velocity.y = -owner.JUMP_VELOCITY
		owner.double_jump = 0
	else:
		owner.animation.play("Air")


func physics_update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction == -1:
		owner.sprite.scale.x = -3
	if direction == 1:
		owner.sprite.scale.x = 3
	if direction and owner.cantm == false and owner.walljump == false:
		owner.velocity.x = direction * owner.SPEED
	elif owner.walljump == true:
		owner.velocity.x -= move_toward(owner.velocity.x, 0, owner.SPEED)
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)
	
	var on_wall_L = owner.left.is_colliding() 
	var on_wall_R = owner.right.is_colliding()

	if Input.is_action_just_pressed("jump") and on_wall_L:
		owner.walljump = true
		owner.cantm = true
		owner.velocity.y = owner.JUMP_VELOCITY
		owner.velocity.x = owner.wall_jump_pushback
		direction = 1
		owner.sprite.scale.x = 3
		owner.animation.play("Double_jump")
		$Timer.start()
		$walljump.start(0.3)
		
		
	if Input.is_action_just_pressed("jump") and on_wall_R:
		owner.walljump = true
		owner.cantm = true
		owner.velocity.y = owner.JUMP_VELOCITY 
		owner.velocity.x = -owner.wall_jump_pushback
		direction = -1
		owner.sprite.scale.x = -3
		owner.animation.play("Double_jump")
		$Timer.start()
		$walljump.start(0.3)
	
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
	
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		%state_machine.transition_to("Dash")

	if Input.is_action_just_pressed("jump") and owner.double_jump == 0 and not owner.is_on_wall():
		owner.animation.play("Double_jump")
		owner.velocity.y = owner.DOUBLE_JUMP
		owner.double_jump = 1

	
	


func _on_timer_timeout():
		$Timer.stop()
		owner.double_jump = 0
		owner.cantm = false


func _on_walljump_timeout():
	$walljump.stop()
	owner.walljump = false
