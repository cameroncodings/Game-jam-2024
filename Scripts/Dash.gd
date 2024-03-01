# Virtual base class for all states.
extends State

# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	owner.move_and_slide()


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	$dashtime.start(0.1)
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	if directionx == 0:
		directionx = owner.sprite.scale.x/3
	owner.velocity.x = directionx * owner.DASH_SPEEDx
	owner.velocity.y = directiony * owner.DASH_SPEEDy
	owner.animation.play("Dash")



# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


func _on_dashtime_timeout():
	$dashtime.stop()
	owner.can_dash = false
	%state_machine.transition_to("Air")
