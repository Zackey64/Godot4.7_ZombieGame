@icon("res://components/attack/icon_attack.png")
class_name AttackComponent extends Component
## 攻撃＋当たり判定の機能を追加する。
## このコンポーネントは例外的に、食らい判定機能（AttackReceiverComponent）を参照し、攻撃を受けたことをシグナルで通知します。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分が攻撃したとき
signal attacked()
## 自分の攻撃が相手に当たったとき
signal attack_hitted(target: CollisionObject2D)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

@onready var _area: Area2D = $HitboxArea
@onready var _shape: CollisionShape2D = $HitboxArea/HitboxShape
@onready var _timer: Timer = $Timer

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

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()
	if hitbox_shape:
		_shape.shape = hitbox_shape
	_area.area_entered.connect(_on_area_entered)
	_timer.one_shot = true
	_timer.timeout.connect(_stop_attack)
	_set_enabled(false)
	
# 外部呼出メソッド－－－－－－－－－－－－－－－－

## 攻撃を開始する処理
func attack() -> void:
	if is_attacking:
		return
	_start_attack()

## 対象のレシーバーに攻撃情報を通知する処理
func hit(target: CollisionObject2D) -> void:
	if target == null:
		return
	for child in target.get_children():
		if child is AttackReceiverComponent:
			child.attack_received.emit(host, damage, knockback)
			return

# 内部処理メソッド－－－－－－－－－－－－－－－

func _start_attack() -> void:
	is_attacking = true
	attacked.emit()
	_timer.start(duration)
	_set_enabled(true) 

func _stop_attack() -> void:
	is_attacking = false
	_set_enabled(false)

func _set_enabled(enabled: bool) -> void:
	_shape.set_deferred("disabled", not enabled)

# シグナルメソッド－－－－－－－－－－－－－－－－

func _on_area_entered(target_area: Area2D) -> void:
	var attack_receiver: AttackReceiverComponent = target_area.get_parent() as AttackReceiverComponent
	if attack_receiver == null or attack_receiver.host == host:
		return
	attack_hitted.emit(attack_receiver.host)
