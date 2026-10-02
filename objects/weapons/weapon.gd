class_name Weapon extends Node

# ----------------------------------------------------------------

enum AttackTrigger {
	PRESSED,       # 押した瞬間
	HOLD,          # 押されている間
	RELEASED,      # 離した瞬間
}

@export var damage: float = 100
@export var attack_trigger: AttackTrigger = AttackTrigger.PRESSED
#@export var data: WeaponData
var owner_entity: Entity


# ----------------------------------------------------------------




# ----------------------------------------------------------------

func setup(owner: Entity) -> void:
	owner_entity = owner
	
func attack(dir: Vector2, input: AttackTrigger) -> void:
	pass
