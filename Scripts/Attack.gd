# Virtual base class for all states.
extends State


func physics_update(delta: float) -> void:
	owner.velocity.y += owner.gravity * delta
# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	owner.velocity.x = 0
	owner.gravity = 1500
	$"../../knife/knifebox".position.x = 40*(owner.sprite.scale.x)
	$"../../knife/knifebox".disabled = false
	$"../../Slash".scale.x = owner.sprite.scale.x
	$"../../Slash".position.x = 40*(owner.sprite.scale.x)
	owner.animation.play("Knife")
	owner.animationk.play("slasj")  
	$attacktime.start(0.4)


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


func _on_attacktime_timeout():
	owner.animationk.play("empty")  
	$"../../knife/knifebox".disabled = true   
	if not owner.is_on_floor():
		%state_machine.transition_to("Air")
		return
	elif owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			%state_machine.transition_to("Idle")
		else:
			%state_machine.transition_to("Run")
