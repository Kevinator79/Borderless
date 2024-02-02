extends CharacterBody2D

@onready var m2d = $Marker2D
@onready var health_bar = $HealthBar
@onready var animate = $Marker2D/AnimationPlayer
@onready var playAgainScreen = $PlayAgain
@export var inv: Inv

var level : int = 1
var experience : int = 0
var health : int = 100
var max_health : int = 100
var attack : int = 5
var speed: float = 100
var jump_force: float = 200
var is_jumping: bool = false
var gravity = 5

var dead: bool = false
var enemy: Enemy
var enemyList: Array = []
var inRangeOfEnemy : bool = false

func _ready():
	health_bar.value = max_health

func _physics_process(_delta):
	if !dead:
		move_and_slide()
		handle_movement()
		handle_attacks()
		update_Animation()

func handle_movement():
	var on_ground: bool = is_on_floor()
	# Reset jump state if the player is on the ground
	if !on_ground:
		velocity.y += gravity
		if velocity.y > 100:
			velocity.y = 100
		
	# Jumping
	if Input.is_action_just_pressed("jump") and on_ground:
		velocity.y -= jump_force
		is_jumping = true
	
	var move_direction = 0
	if Input.is_action_pressed("move_right"):
		m2d.scale.x = 1
		move_direction += 1
	if Input.is_action_pressed("move_left"):
		m2d.scale.x = -1
		move_direction -= 1
		
	velocity.x = speed * move_direction
	move_and_slide()

func handle_attacks():
	if Input.is_action_pressed("attack") and inRangeOfEnemy:
		melee_attack()
	pass

func player():
	pass

func collect(item):
	inv.insert(item)

func melee_attack():
	for enemies in enemyList:
		if enemies.has_method("take_damage"):
			enemies.take_damage(attack)

func take_damage(damage):
	health -= damage
	if health <= 0:
		death()
	update_health_bar()
	
func update_Animation():
	if !dead:
		if velocity.length() == 0 and is_on_floor():
			animate.play("Idle")
		else:
			var animation_Name = "RESET"
			if !is_on_floor(): animation_Name = "Jump"
			elif is_on_floor() and velocity.x != 0 :animation_Name = "Walk"
			animate.play(animation_Name)

func update_health_bar():
	health_bar.value = health
	
func death():
	dead = true
	animate.play("Death")
	playAgainScreen.show()
	#queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		enemyList.append(body)
		inRangeOfEnemy = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemy"):
		enemyList.erase(body)
		if enemyList.size() == 0:
			inRangeOfEnemy = false
