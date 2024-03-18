extends CharacterBody2D

const SPEED = 400
var direction = Vector2.LEFT
const RUN = 1000

@onready var sprite = $Sprite2D
@onready var floor := $floor
@onready var wallL := $wallL
@onready var wallR := $wallR

var hp = 2
var chaseL = false
var chaseR = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play('run')

func _physics_process(_delta):
	if $SeeplayerL.is_colliding():
		if $SeeplayerL.get_collider().name == "Player" and sprite.scale.x == 2.5:
			chaseL = true
	
	if $SeeplayerR.is_colliding():
		if $SeeplayerR.get_collider().name == "Player" and sprite.scale.x == -2.5:
			chaseR = true
	var wall = wallR.is_colliding() or wallL.is_colliding() 
	var florr = not floor.is_colliding() 
	if florr == true or wall == true:
		direction *= -1
		sprite.scale.x *= -1
		$stop.start(0.1)

	if chaseL == false or chaseR == false:
		velocity = direction * SPEED
	if chaseL == true:
		velocity = RUN * direction
	elif chaseR == true:
		velocity = RUN * direction
	move_and_slide()

func _on_hitox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_hitox_area_entered(area):
	if area.name == "knife" or area.name == "groundpound":
		queue_free()


func _on_stop_timeout():
	chaseL = false
	chaseR = false
