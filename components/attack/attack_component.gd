@icon("res://components/attack_icon.png")
class_name AttackComponent extends Component
## 攻撃＋当たり判定の機能を追加する。
## このコンポーネントは例外的に、体力＋食らい判定機能（HealthComponent）を参照し、攻撃を受けたことをシグナルで通知します。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分が攻撃したとき
signal attacked()
## 自分の攻撃が相手に当たったとき
signal hitted(target: CollisionObject2D)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var area: Area2D = $Area2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

# インスペクタ変数－－－－－－－－－－－－－－－－

## 相手へのダメージ量
@export var damage: float = 10.0
## 当たり判定の形状
@export var hitbox_shape: Shape2D

# 状態変数－－－－－－－－－－－－－－－－－－－－

## 自分が攻撃中かどうか
var is_attacking: bool = false

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	if hitbox_shape:
		collision_shape.shape = hitbox_shape
	area.area_entered.connect(_on_area_entered)
	collision_shape.set_deferred("disabled", true)
	
# 外部呼出メソッド－－－－－－－－－－－－－－－－

func start_attack() -> void:
	if is_attacking:
		return
	is_attacking = true
	collision_shape.set_deferred("disabled", false)
	attacked.emit()

func stop_attack() -> void:
	if not is_attacking:
		return
	is_attacking = false
	collision_shape.set_deferred("disabled", true)

func attack(target: CollisionObject2D) -> void:
	if target:
		for child in target.get_children():
			if child is HealthComponent:
				child.hitted.emit(self.host, damage)
				break

# シグナルメソッド－－－－－－－－－－－－－－－－

func _on_area_entered(area: Area2D) -> void:
	var health_C := area.get_parent() as HealthComponent
	if health_C:
		hitted.emit(health_C.host)
