extends Node
@export var Meth_scene: PackedScene
@export var mob_scene: PackedScene
var score




func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$MethTimer.stop()
	
func new_game():
	get_node("intro").visible = false
	score = 0
	$MethTimer.start()
	$player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func _on_score_timer_timeout():
	score += 0
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
func Meth():
	score += 1
	$HUD.update_score(score)
	$MethSound.play()
	$MobTimer.wait_time *= 0.8
	



func _on_meth_timer_timeout():
	var Meth = Meth_scene.instantiate()
	var screen_size = get_viewport().get_visible_rect().size
	var randX = randi_range(0,screen_size.x)
	var randY = randi_range(0,screen_size.y)
	Meth.position = Vector2(randX, randY); 
	add_child(Meth)
	
