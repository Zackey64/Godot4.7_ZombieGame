class_name Bullet extends Projectile

# ----------------------------------------------------------------

@onready var attack_C: AttackComponent = $AttackComponent

# ----------------------------------------------------------------


func setup(owner: Entity, pos: Vector2, dir: Vector2, speed: float, range: float) -> void:
	super.setup(owner, pos, dir, speed, range)
	


func hit(target: Entity) -> void:
	self.attack_C.hit(target)
	destroy()
