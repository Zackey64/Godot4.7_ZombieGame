@icon("res://components/hurtbox/hurtbox_icon.png")
class_name AttackReceiverComponent extends Component
## 食らい判定の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 相手の攻撃が自分に当たったとき
signal attack_received(
	attacker: CollisionObject2D,
	damage: float,
	knockback: float,
)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var area: Area2D = $HurtboxArea
@onready var shape: CollisionShape2D = $HurtboxArea/HurtboxShape

# インスペクタ変数－－－－－－－－－－－－－－－－

## 当たり判定の形状
@export var hurtbox_shape: Shape2D

# 状態変数－－－－－－－－－－－－－－－－－－－－

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	if hurtbox_shape:
		shape.shape = hurtbox_shape
	
# 外部呼出メソッド－－－－－－－－－－－－－－－－

func set_enabled(enabled: bool) -> void:
	shape.set_deferred("disabled", not enabled)

# 内部処理メソッド－－－－－－－－－－－－－－－－

# シグナルメソッド－－－－－－－－－－－－－－－－
