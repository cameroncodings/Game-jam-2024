extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var animationk = $AnimationPlayerk
@onready var left := $left
@onready var right := $right
const SPEED = 800.0
const JUMP_VELOCITY = -800.0
const DOUBLE_JUMP = -750.0
const wall_jump_pushback = 2000
const DASH_SPEEDy = 1000
const DASH_SPEEDx = 3000
const PUSH_BACK = 1000
const PUSH_UP = -500
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1500
var mini_jump = 0
var double_jump = 0
var cancely = 0
var hp = 3
var knockbackdir = 0

var iframe = false
var cantcantm = false
var cantm = false
var walljump = false
var can_dash = true


func _physics_process(_delta):
	move_and_slide()
	
	if iframe == false:
		$Sprite2D.modulate = Color(1, 1, 1)
	elif iframe == true:
		$Sprite2D.modulate = Color(0, 0, 0)

func hurt():
	if iframe == false:
		cantcantm = true
		cantm = true
		velocity.y = PUSH_UP
		if sprite.scale.x == 3:
			velocity.x = -PUSH_BACK
			sprite.scale.x = 3
			
		if sprite.scale.x == -3:
			velocity.x = PUSH_BACK
			sprite.scale.x = -3
		$knockback.start(1)
		animation.play("knockback")
		hp -= 1
		if hp <= 0:
			get_tree().change_scene_to_file("res://Scenes/death.tscn")
		%state_machine.transition_to("Air")
		iframe = true
		$iframetime.start(1)


func _on_knockback_timeout():
	cantcantm = false
	cantm = false


func _on_iframetime_timeout():
	iframe = false
