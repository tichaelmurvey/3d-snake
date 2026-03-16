extends CharacterBody3D

@export var trailScene: PackedScene

const SPEED = 5.0
const STEERING_POWER = 2.0

var frame_count: int = 0

const TRAIL_OFFSET: float = 3.0

func generate_trail() -> void:
	print("Generating trail segment")
	# Create a new trail segment at the current position
	var trail_segment = trailScene.instantiate()
	# trail_segment.position = position - Vector3(0, 0, 1)
	trail_segment.global_position = global_position
	trail_segment.rotation = rotation

	# Add the trail segment to the trail array
	get_parent().add_child(trail_segment)

	# Update the trail array - and remove any segments that are too old

	pass


const trail_refresh_rate: int = 10

# This is called on every physics tick
func _physics_process(delta: float) -> void:
	frame_count += 1
	if frame_count % trail_refresh_rate == 0:
		generate_trail()
		frame_count = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir:
		rotation -= Vector3(input_dir.y, input_dir.x, 0) * STEERING_POWER * delta
	velocity = global_transform.basis.z * SPEED
	
	move_and_slide()
	var collision: KinematicCollision3D = get_last_slide_collision()
	if collision:
		handle_collision(collision)


# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Collision Detection
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
func handle_collision(collision: KinematicCollision3D) -> void:
	var collider = collision.get_collider()
	print("Collision detected with: ", collision.get_collider().name)
	Game.game_over()
