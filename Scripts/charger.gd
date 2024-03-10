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
var chase = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimationPlayer.play('run')
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	print(sprite.scale.x)
	var wall = wallR.is_colliding() or wallL.is_colliding() 
	var L = not left.is_colliding() 
	var R = not right.is_colliding()
	var seenplayerL = seeL.is_colliding()
	var seenplayerR = seeR.is_colliding()
	
	if L or R or wall:
		direction *= -1
		sprite.scale.x *= -1
	
	if chase == false or L or R or wall:
		velocity = direction * SPEED
	if seenplayerL == true and sprite.scale.x == 2.5 and L == false or R == false or wall == false:
		chase = true
		velocity = direction * SPEED * 10
	elif seenplayerR == true and sprite.scale.x == -2.5 and L == false or R == false or wall == false:
		chase = true
		velocity = -direction * SPEED * 10
	move_and_slide()
	
func _on_hitox_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_hitox_area_entered(area):
	if area.name == "knife" or area.name == "groundpound":
		queue_free()
