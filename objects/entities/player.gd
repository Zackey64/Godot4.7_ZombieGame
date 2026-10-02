class_name Player extends Entity

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@onready var weapon: RangeWeapon = $RangeWeapon

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	var input_vector = Input.get_vector('move_left','move_right','move_forward','move_back')
	move_C.add_velocity(delta, input_vector)
	#var input_rotation = Input.get_axis("turn_left", "turn_right")
	#direction_C.add_direction(delta, input_rotation)
	var input_rotation = get_global_mouse_position().angle_to_point(position) - PI
	direction_C.set_direction(delta, input_rotation)

	if Input.is_action_just_pressed("ui_accept"):
		attack_C.attack()
		
	weapon.owner_entity = self
	if Input.is_action_just_pressed("attack"):
		weapon.attack(Vector2.from_angle(rotation), Weapon.AttackTrigger.PRESSED)
	elif Input.is_action_pressed("attack"):
		weapon.attack(Vector2.from_angle(rotation), Weapon.AttackTrigger.HOLD)
	elif Input.is_action_just_released("attack"):
		weapon.attack(Vector2.from_angle(rotation), Weapon.AttackTrigger.RELEASED)
