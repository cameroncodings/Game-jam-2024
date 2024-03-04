extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var left := $left
@onready var right := $right
const SPEED = 800.0
const JUMP_VELOCITY = -800.0
const DOUBLE_JUMP = -750.0
const wall_jump_pushback = 2000
const DASH_SPEEDy = 1000
const DASH_SPEEDx = 3000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1500
var mini_jump = 0
var double_jump = 0
var cancely = 0
var hp = 3

var hurty = false
var cantm = false
var walljump = false
var can_dash = true

func _physics_process(delta):
	if hurty == true:
		velocity.y = JUMP_VELOCITY
		velocity.x = wall_jump_pushback*(sprite.scale/3)
		hurty = false

func hurt():
	hurty = true
	hp -= 1
	if hp <= 0:
		get_tree().reload_current_scene()


func _on_knockback_timeout():
	cantm = false
	
