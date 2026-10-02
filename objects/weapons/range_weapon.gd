class_name RangeWeapon extends Weapon

@onready var timer: Timer = $Timer

@export var projectile: PackedScene
@export var projectile_speed: float = 640.0
@export var projectile_range: float = 640.0
@export var interval: float = 0.1
@export var spread: float = 0.01




func attack(dir: Vector2, input: AttackTrigger) -> void:
	if input != attack_trigger:
		return
	if not timer.is_stopped():
		return
	fire(dir)
	timer.start(interval)

func fire(direction: Vector2) -> void:
	var angle = randf_range(-spread, spread)
	var final_direction = direction.rotated(angle)
	
	var projectile_i = projectile.instantiate() as Projectile
	get_tree().current_scene.add_child(projectile_i)
	projectile_i.setup(
		owner_entity,
		owner_entity.global_position,
		final_direction,
		projectile_speed,
		projectile_range
	)
