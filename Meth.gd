extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Meth_picked_up():
	queue_free()

func _on_area_entered(area):
	get_tree().root.get_node("Main").Meth()
	Meth_picked_up()

func _on_timer_timeout():
	queue_free()
