@icon("res://components/health_icon.png")
class_name HealthComponent extends Component
## 体力＋食らい判定の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 相手の攻撃が自分に当たったとき
signal hitted(target: CollisionObject2D, amount: float)
## 自分がダメージを受けたとき
signal damaged(amount: float)
## 自分が死んだとき
signal died()

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var area: Area2D = $Area2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

# インスペクタ変数－－－－－－－－－－－－－－－－

@export var max_health: float = 100.0
@export var hurtbox_shape: Shape2D

# 状態変数－－－－－－－－－－－－－－－－－－－－

var health: float

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	health = max_health
	if hurtbox_shape:
		collision_shape.shape = hurtbox_shape

# 外部呼出メソッド－－－－－－－－－－－－－－－－

## ダメージを受ける処理
func damage(amount: float) -> void:
	if amount <= 0: return
	health -= amount
	health = clamp(health, 0, max_health)
	damaged.emit(amount)
	if health == 0: died.emit()

## 回復する処理
func heal(amount: float) -> void:
	if amount <= 0: return
	health += amount
	health = clamp(health, 0, max_health)

# シグナルメソッド－－－－－－－－－－－－－－－－
