extends Node3D
class_name Main


const CHUNK_OFFSET = -16.499 #chunk offset(the distance between one chunk and the other) -- I found this by just checking the size and ensuring it can allign properly to the next
static var chunks:Array[chunk] = [] #the currently loaded chunks -- This is Static for a reason
var chunk_packed_scene = preload("res://Objects/chunk1.tscn") # the chunk example, ofc if you're doing random this is probably different, probabyly...
var last_z := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in chunks: #so in godot, a static variable does not reset when changing scenes, we gotta get rid of all the chunks loaded
		if is_instance_valid(i):
			i.queue_free()
	chunks.clear() # and just to be safe we run this which clears out the array for good
# function used to generate chunks
func _generation():
	for i in 6 : #enerates 6 more of them, this  number can be altered for your needs
		var chunk_instance :chunk= chunk_packed_scene.instantiate() #instantiates the node
		add_child(chunk_instance) #Adds the chunk instance to the scene
		if chunks.size() != 0:
			last_z = chunks.back().global_position.z # gets the last generated chunk's z position
		chunk_instance.global_position.z = last_z + CHUNK_OFFSET # sets the chunk position based off the last chunk loaded and an offeet(size of that chunk)
		chunks.append(chunk_instance) # adds to the array(this adds it to the back, not the front GET IT RIGHT NERD)
		
		
		
func _process(delta: float) -> void:
	chunks = chunks.filter(func(c): return is_instance_valid(c) and not c.is_queued_for_deletion()) #filters out any chunks that are about to be deleted
	if chunks.size() < 5: # if we're running low on chunks(to see how chunk size decreases go to the chunk script where it deletes it from the array) 
		_generation() # generate more
	
	
# PHOENIX(Carsen) plz no copy and paste cuz that is lame
