extends Node2D

@export var mob_scene: PackedScene

func _on_mob_timer_timeout():
	#Create new instance of mob
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = %MobSpawnLocation #TODO
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
