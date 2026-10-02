@icon("res://components/attack/attack_icon.png")
class_name AttackComponent extends Component
## 攻撃＋当たり判定の機能を追加する。
## このコンポーネントは例外的に、食らい判定機能（AttackReceiverComponent）を参照し、攻撃を受けたことをシグナルで通知します。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分が攻撃したとき
signal attacked()
## 自分の攻撃が相手に当たったとき
signal attack_hitted(target: CollisionObject2D)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var area: Area2D = $HitboxArea
@onready var shape: CollisionShape2D = $HitboxArea/HitboxShape
@onready var timer: Timer = $Timer

# インスペクタ変数－－－－－－－－－－－－－－－－

## 攻撃によって与えるダメージ
@export var damage: float = 10.0
## 攻撃によって与えるノックバック
@export var knockback: float = 5.0
## 攻撃を継続する時間
@export var duration: float = 0.2
## 次の攻撃までの攻撃を継続する時間
@export var cooldown: float = 0.2
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
		shape.shape = hitbox_shape
	area.area_entered.connect(_on_area_entered)
	timer.one_shot = true
	timer.timeout.connect(_stop_attack)
	set_enabled(false)
	
# 外部呼出メソッド－－－－－－－－－－－－－－－－

func attack() -> void:
	if is_attacking:
		return
	_start_attack()

func hit(target: CollisionObject2D) -> void:
	if target == null:
		return
	for child in target.get_children():
		if child is AttackReceiverComponent:
			child.attack_received.emit(host, damage, knockback)
			return

func set_enabled(enabled: bool) -> void:
	shape.set_deferred("disabled", not enabled)

# 内部処理メソッド－－－－－－－－－－－－－－－

func _start_attack() -> void:
	is_attacking = true
	attacked.emit()
	timer.start(duration)
	set_enabled(true) 

func _stop_attack() -> void:
	is_attacking = false
	set_enabled(false)

# シグナルメソッド－－－－－－－－－－－－－－－－

func _on_area_entered(target_area: Area2D) -> void:
	var attac_recever: AttackReceiverComponent = target_area.get_parent() as AttackReceiverComponent
	if attac_recever:
		if attac_recever.host != self.host:
			attack_hitted.emit(attac_recever.host)
