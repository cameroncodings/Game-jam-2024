extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var left := $left
@onready var right := $right
const SPEED = 700.0
const JUMP_VELOCITY = -800.0
const DOUBLE_JUMP = -700.0
const wall_jump_pushback = 2000
const DASH_SPEEDy = 1000
const DASH_SPEEDx = 3000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 3000
var mini_jump = 0
var ground_pound = 20000
var double_jump = 0
var cancely = 0

var cantm = false
var walljump = false
var can_dash = true
