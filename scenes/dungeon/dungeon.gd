extends Node2D


# Called when the node enters the scene tree for the first time.


func on_time_out_first_timer():
	var controlled_npc = get_node('Controlled_npc') as Node2D
	print(controlled_npc)
	if controlled_npc == null:
		return
	controlled_npc.queue_free()
