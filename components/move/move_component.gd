# @icon("res://components/health.png")
class_name MoveComponent extends Component
## 移動の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# 定数＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

const TILE_SIZE = 32

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ノード参照－－－－－－－－－－－－－－－－－－－
# インスペクタ変数－－－－－－－－－－－－－－－－

## 移動速度（タイル/秒）
@export var walk_speed: float = 2.0
@export var run_speed: float = 3.0

# 状態変数－－－－－－－－－－－－－－－－－－－－

var is_running: bool = false

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ライフサイクルメソッド－－－－－－－－－－－－－
# 外部呼出メソッド－－－－－－－－－－－－－－－－

## 移動する
func add_move (_delta: float, vector: Vector2) -> void:
	if vector == Vector2.ZERO:
		return
	var speed = run_speed if is_running else walk_speed
	var final_speed = speed * TILE_SIZE
	host.velocity = vector.limit_length() * final_speed
	host.move_and_slide()
