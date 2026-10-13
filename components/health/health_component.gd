@icon("res://components/health/icon_health.png")
class_name HealthComponent extends Component
## 体力の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分がダメージを受けたとき
signal damaged(attacker: CollisionObject2D, damage: float)
## 自分が死んだとき
signal died(attacker: CollisionObject2D)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

# インスペクタ変数－－－－－－－－－－－－－－－－

@export var max_health: float = 100.0

# 状態変数－－－－－－－－－－－－－－－－－－－－

var health: float

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	health = max_health

# 外部呼出メソッド－－－－－－－－－－－－－－－－

## ダメージを受ける処理
func damage(attacker: CollisionObject2D, damage: float) -> void:
	if damage <= 0:
		return
	health -= damage
	health = clamp(health, 0, max_health)
	damaged.emit(attacker, damage)
	if health == 0:
		died.emit(attacker)

## 回復する処理
func heal(amount: float) -> void:
	if amount <= 0:
		return
	health += amount
	health = clamp(health, 0, max_health)

# 内部処理メソッド－－－－－－－－－－－－－－－－

# シグナルメソッド－－－－－－－－－－－－－－－－
