extends CharacterBody2D
class_name Enemy
@onready var attack_hitbox = $attack_hitbox/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var portal = $"../../GroundLayer/Portal"
@onready var chest = $"../../DropLayer/Chest"

var speed = 50
var health = 100
var dead = false
var player_in_area = false
var player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	dead = false
	#No need for disabling this 
	#attack_hitbox.disabled
	animated_sprite_2d.play("default")
	health_bar.value = health
	
func _physics_process(_delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			var velocity_calc = position.direction_to(player.position) * speed
			velocity.x = velocity_calc[0]
			#flip enemy if moving left
			var isLeft = velocity.x < 0
			animated_sprite_2d.flip_h = isLeft
			if isLeft:
				attack_hitbox.position.x = -90
				attack_hitbox.rotation_degrees = -235
			else:
				attack_hitbox.position.x = 39
				attack_hitbox.rotation_degrees = 61.2
			move_and_slide()
	if dead:
		$detection_area/CollisionShape2D.disabled = true
func _on_body_hitbox_body_entered(body):
	#hitbox for enemy in which it will take damage
	#do I really need this? can the player just do it directly?
	if body.has_method("player"):
		#var damage
		#take_damage(damage)
		pass
	

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body
		animated_sprite_2d.play("attacking")
		attack_hitbox.set_deferred("disabled", false)

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		player = null
		animated_sprite_2d.play("default")
		attack_hitbox.set_deferred("disabled", true)

func _on_attack_hitbox_body_entered(body):
	if body.has_method("player"):
		var damage = 10
		player.take_damage(damage)
		await get_tree().create_timer(2).timeout
		
func take_damage(damage):
	if health <= 0 and !dead:
		death()
	health = health - damage
	update_health_bar()

func update_health_bar():
	health_bar.value = health
	
func death():
	dead = true
	queue_free()
	portal.open_portal()
	chest.spawn_chest()
