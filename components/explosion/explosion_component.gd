@icon("res://components/knockback/icon_explosion.png")
class_name ExplosionComponent extends Component
## 爆発の機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分が爆発したとき
signal exploded()

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var _area: Area2D = $ExplosionArea
@onready var _shape: CollisionShape2D = $ExplosionArea/ExplosionShape

# インスペクタ変数－－－－－－－－－－－－－－－－

@export var damage: float = 10
@export var knockback: float = 10
@export var radius: float = 64

# 状態変数－－－－－－－－－－－－－－－－－－－－

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	if _shape.shape is CircleShape2D:
		_shape.shape.radius = radius

# 外部呼出メソッド－－－－－－－－－－－－－－－－

## 爆発する
func explode() -> void:
	await get_tree().physics_frame
	for target_area in _area.get_overlapping_areas():
		_process_hit_area(target_area)
	exploded.emit()


# 内部処理メソッド－－－－－－－－－－－－－－－－

func _process_hit_area(target_area: Area2D) -> void:
	var attack_receiver: AttackReceiverComponent = target_area.get_parent() as AttackReceiverComponent
	if attack_receiver == null or attack_receiver.host == host:
		return
	attack_receiver.attack_received.emit(host, damage, knockback)
	

# シグナルメソッド－－－－－－－－－－－－－－－－
