extends CharacterBody2D

const SPEED = 200
var direction = Vector2.LEFT

@onready var left := $left
@onready var right := $right
@onready var wallL := $wallL
@onready var wallR := $wallR
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play('run')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var wall = wallR.is_colliding() or wallL.is_colliding() 
	var L = not left.is_colliding() 
	var R = not right.is_colliding()
	
	if L or R or wall:
		direction *= -1
		$Sprite2D.scale.x *= -1
		
		
	velocity = direction * SPEED
	move_and_slide()

func _on_hitox_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()


func _on_hitox_area_entered(area):
	if area.name == "knife":
		queue_free()
