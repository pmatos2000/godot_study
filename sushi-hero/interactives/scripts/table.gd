extends MeshInstance3D

static var _chair_packed: PackedScene = load("res://furniture/environment/stool.tscn")

const AMOUNT_MAX: int = 4

static var _chair_position: Array[Vector3] = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(-2, 0, 0),
	Vector3(0, 0, -2),
]

static var _chair_offset_positio: Array = _chair_position.map(
	func(v: Vector3) -> Vector3: return 0.2 * v) 

static var _angle_rotation: Array[float] = [0, PI, -PI/2, PI]

func initializer_chairs() -> void:
	var indexes: Array = range(AMOUNT_MAX)
	indexes.shuffle()
	indexes = indexes.slice(0, randi() % AMOUNT_MAX + 1)
	for index: int in indexes:
		var chair: MeshInstance3D =  _chair_packed.instantiate()
		chair.transform.origin = _chair_position[index]
		chair.set_meta("chair_index", index)
		add_child(chair)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializer_chairs()
