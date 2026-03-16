extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale_factor = Game.GAME_BOX_SIZE/100
	scale = Vector3(scale_factor, scale_factor, scale_factor)
	# scale = Vector3(Game.GAME_BOX_SIZE/100, Game.GAME_BOX_SIZE/100, Game.GAME_BOX_SIZE/100)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
