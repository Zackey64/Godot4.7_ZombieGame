class_name Enemy extends Entity

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@onready var explosion_C: ExplosionComponent = $ExplosionComponent

@export var target :Entity

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	

	if target:
		var input_vector = Vector2.RIGHT.rotated(self.rotation)
		move_C.add_velocity(delta, input_vector)
		direction_C.set_direction_to_target(delta, target)
		
		if self.global_position.distance_to(target.global_position) < 40:
			attack_C.attack()

func on_died(attacker: CollisionObject2D) -> void:
	explosion_C.explode()
	super.on_died(attacker)
	
