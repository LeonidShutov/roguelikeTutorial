extends Node2D


const MOVE_LEFT: StringName = &"move_left"
const MOVE_RIGHT: StringName = &"move_right"
const MOVE_UP: StringName = &"move_up"
const MOVE_DOWN: StringName = &"move_down"

const MOVE_INPUTS: Array[StringName] = [
	MOVE_LEFT,
	MOVE_RIGHT,
	MOVE_UP,
	MOVE_DOWN,
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Palette.get_color({}, MainTag.BACKGROUND, true))
	_create_pc()


func _create_pc() -> void:
	var new_pc: Sprite2D = preload("res://sprite/pc.tscn").instantiate()
	var new_position: Vector2i = Vector2i(0, 0)
	new_pc.position = ConvertCoord.get_position(new_position)
	new_pc.modulate = Palette.get_color({}, MainTag.ACTOR, true)
	new_pc.add_to_group(SubTag.PC)
	add_child(new_pc)

func _move_pc(direction: StringName) -> void:
	var pc: Sprite2D = get_tree().get_first_node_in_group(SubTag.PC)
	var coord: Vector2i = ConvertCoord.get_coord(pc)

	match direction:
		MOVE_LEFT:
			coord += Vector2i.LEFT
		MOVE_RIGHT:
			coord += Vector2i.RIGHT
		MOVE_UP:
			coord += Vector2i.UP
		MOVE_DOWN:
			coord += Vector2i.DOWN
	pc.position = ConvertCoord.get_position(coord)

func _unhandled_input(event: InputEvent) -> void:
	for i: StringName in MOVE_INPUTS:
		if event.is_action_pressed(i):
			_move_pc(i)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
