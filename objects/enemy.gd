class_name Enemy extends Entity

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@export var target :Entity

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	var input_vector = Vector2.RIGHT.rotated(self.rotation)
	move_C.add_move(delta, input_vector)
	direction_C.set_direction_to_target(delta, target)

func on_died() -> void:
	super.on_died()
	self.queue_free()
