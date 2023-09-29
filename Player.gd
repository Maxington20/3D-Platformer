extends CharacterBody3D

var move_speed : float = 4
var jump_force : float = 8
var gravity : float = 20

var facing_angle : float

var score : int = 0

@onready var model : MeshInstance3D = get_node("Model")

@onready var score_text : Label = get_node("ScoreText")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = Vector3(input.x, 0, input.y)
	
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	move_and_slide()
	
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()
	
	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)
	
	if global_position.y < -5:
		game_over()

func game_over():
	get_tree().reload_current_scene()
	
func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)
