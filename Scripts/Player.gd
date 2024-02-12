extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0
const DOUBLE_JUMP = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1500
var mini_jump = 0
var ground_pound = 10000
var double_jump = 0
