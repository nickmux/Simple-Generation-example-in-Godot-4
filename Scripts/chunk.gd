extends Node3D
class_name chunk 




func _not_visible() -> void: # Signal from visibleNotifier3d(On screen exited)
	Main.chunks.erase(self) # Removes the chunk from the array of currently loaded chunks
	queue_free() # removes itself from the world
