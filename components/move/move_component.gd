@icon("res://components/move/move_icon.png")
class_name MoveComponent extends Component
## 移動の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# 定数＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

const TILE_SIZE = 32
# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

# インスペクタ変数－－－－－－－－－－－－－－－－

# 状態変数－－－－－－－－－－－－－－－－－－－－

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－
# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var cooldown_timer: Timer = $Timer

# インスペクタ変数－－－－－－－－－－－－－－－－

## 移動速度（タイル/秒）
@export var max_speed: float = 3.0
@export var add_speed: float = 15.0

# 状態変数－－－－－－－－－－－－－－－－－－－－

#var can_move: bool = true

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ライフサイクルメソッド－－－－－－－－－－－－－

# 外部呼出メソッド－－－－－－－－－－－－－－－－

## 速度を徐々に最大速度まで加算する。
func add_velocity(delta: float, direction: Vector2) -> void:
	var target_velocity = direction.limit_length() * max_speed * TILE_SIZE
	var final_speed = add_speed * TILE_SIZE * delta
	host.velocity = host.velocity.move_toward(target_velocity , final_speed)
	host.move_and_slide()

## 速度を強制的に最大速度を無視して加算する。
func force_add_velocity(vector: Vector2) -> void:
	if vector == Vector2.ZERO:
		return
	host.velocity += vector * TILE_SIZE

#func set_cooldown(time: float) -> void:

# シグナルメソッド－－－－－－－－－－－－－－－－
