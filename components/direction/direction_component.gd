# @icon("res://components/health.png")
class_name DirectionComponent extends Component
## 向きの機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ノード参照－－－－－－－－－－－－－－－－－－－
# インスペクタ変数－－－－－－－－－－－－－－－－

## 回転速度（回転/秒）
@export var turn_speed: float = 2.0

# 状態変数－－－－－－－－－－－－－－－－－－－－

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ライフサイクルメソッド－－－－－－－－－－－－－
# 外部呼出メソッド－－－－－－－－－－－－－－－－

## 角度を速度分加算する。
func add_rotation (delta: float, axis: float) -> void:
	if axis == 0:
		return
	axis = clamp(axis, -1.0, 1.0)
	var final_speed = turn_speed * TAU * delta
	host.rotation += axis * final_speed

func force_set_direction (target_angle: float) -> void:
	host.rotation = target_angle

func set_direction (delta: float, target_angle: float) -> void:
	var final_speed = turn_speed * TAU * delta
	host.rotation = rotate_toward(host.rotation, target_angle, final_speed)

func set_direction_to_target (delta: float, target: CollisionObject2D) -> void:
	if target == null:
		return
	var angle = host.global_position.angle_to_point(target.global_position)
	set_direction(delta, angle)
