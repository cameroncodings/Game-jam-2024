extends CharacterBody2D

const SPEED = 200
var direction = Vector2.LEFT


@onready var sprite = $Sprite2D
@onready var seeL := $SeeplayerL
@onready var seeR := $SeeplayerR
@onready var left := $left
@onready var right := $right
@onready var wallL := $wallL
@onready var wallR := $wallR

var hp = 2
var chaseL = false
var chaseR = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimationPlayer.play('run')
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var wall = wallR.is_colliding() or wallL.is_colliding() 
	var L = not left.is_colliding() 
	var R = not right.is_colliding()
	var seenplayerL = seeL.is_colliding()
	var seenplayerR = seeR.is_colliding()
	
	if L or R or wall:
		direction *= -1
		sprite.scale.x *= -1
	
	if chaseL == false or chaseR == false or L or R or wall:
		velocity = direction * SPEED
	if seenplayerL == true and sprite.scale.x == 2.5 and chaseL == true and L == false and R == false and wall == false:
		velocity = sprite.scale.x/2.5 * SPEED * 5 * direction
	elif seenplayerR == true and sprite.scale.x == -2.5 and chaseR == true and L == false and R == false and wall == false:
		velocity = sprite.scale.x/2.5 * SPEED * 5 * -direction
	move_and_slide()
	
func _on_hitox_body_entered(body):
	if body.name == "Player":
		chaseR = false
		chaseL = false
		body.hurt()


func _on_hitox_area_entered(area):
	if area.name == "knife" or area.name == "groundpound":
		queue_free()



func _on_area_2dl_body_entered(body):
	if body.name == "Player":
		chaseL = true


func _on_area_2dl_body_exited(body):
	if body.name == "Player":
		chaseL = false



func _on_area_2dr_body_entered(body):
	if body.name == "Player":
		chaseR = true


func _on_area_2dr_body_exited(body):
	if body.name == "Player":
		chaseR = false


