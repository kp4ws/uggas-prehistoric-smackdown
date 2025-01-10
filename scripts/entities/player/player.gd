#This node is the host of the state machine
class_name Player extends CharacterBody2D

@export var data: PlayerData
@export var modifiers: PlayerModifiers
@onready var health_component: Health = $Health

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var punch_fx: AnimatedSprite2D = $PunchFX_AnimatedSprite2D
@onready var land_fx: AnimatedSprite2D = $LandFX_AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_collider: CollisionShape2D = $PlayerCollider2D
@onready var invincibility_timer: Timer = $Timers/InvincibilityTimer
@onready var attack_ray_cast: RayCast2D = $AttackRayCast2D

@onready var climb_up_ray_cast: RayCast2D = $ClimbUpRayCast2D
@onready var climb_down_ray_cast: RayCast2D = $ClimbDownRayCast2D

var respawnPosition: Vector2 = Vector2.ZERO

func _ready():
	#respawnPosition = self.position
	if SceneManager.spawn_positions.has(SceneManager.current_scene):
		position = SceneManager.spawn_positions[SceneManager.current_scene]
		
	_load_player_data()
	_subscribe()
	
func _subscribe():
	#TODO if my game is going to include saving/continuing, then this will need refactoring
	GlobalSignals.start_game.connect(_reset_saved_data)
	
	health_component.entity_damaged.connect(_on_take_damage)
	health_component.entity_died.connect(_on_die)
	health_component.entity_healed.connect(_on_heal)

func _load_player_data():
	health_component.health = data.health

func _reset_saved_data():
	data.health = health_component.max_health
	#data = PlayerData.new() #TODO Test out and make sure this works as expected

func _physics_process(_delta):
	if health_component.health == 0:
		#TODO is there a better way to disable input ?
		#TODO in death state, if health_component == 0 then just state and don't allow player to move?
		velocity.x = 0.0
		return

	_flip_sprite()
	
func _flip_sprite():
	#-1, 0, 1
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#Flip the sprite
	if input_direction_x > 0:
		animated_sprite.flip_h = false
		punch_fx.flip_h = false
		punch_fx.position.x = player_collider.position.x + 50
		
		attack_ray_cast.target_position.x = modifiers.attack_distance
	elif input_direction_x < 0:
		animated_sprite.flip_h = true
		punch_fx.flip_h = true
		punch_fx.position.x = player_collider.position.x - 45
		
		attack_ray_cast.target_position.x = -modifiers.attack_distance

func on_finished_hurt_anim():
	#Called from animation player
	animation_player.stop() #Force animation player to stop before disabling invincibility (fixes bug)
	health_component.invincible = false

func respawn():
	#TODO Needs updating (use spawn_positions from scene_manager)
	
	#TODO .smoothing isn't correct property
	%MainCamera.smoothing = false
	self.position = respawnPosition
	%MainCamera.smoothing = true

func _on_die():
	data.set_health(health_component.health) #Should be 0 at this point
	await get_tree().create_timer(1).timeout #TODO Error between this and killzone where it doesn't actually reload the level
	
	#TODO Call gameover scene
	SceneManager.load_main_menu()

func _on_take_damage(attacker):
	#TODO initiate damageFX and invincibility timer
	data.set_health(health_component.health)
	animation_player.play('player_hurt_anim')	
	health_component.invincible = true

func _on_heal():
	#TODO healthFX
	data.set_health(health_component.health)
