class_name Entity extends CharacterBody2D

@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

@onready var move_C: MoveComponent = $MoveComponent
@onready var direction_C: DirectionComponent = $DirectionComponent
@onready var health_C: HealthComponent = $HealthComponent
@onready var attack_C: AttackComponent = $AttackComponent
@onready var attack_recever_C: AttackReceiverComponent = $AttackReceiverComponent
@onready var knockback_C: KnockbackComponent = $KnockbackComponent

# --------------------------------
# ライフサイクル
# --------------------------------

func _ready() -> void:
	attack_C.attacked.connect(on_attacked)
	attack_C.attack_hitted.connect(on_hitted)
	attack_recever_C.attack_received.connect(on_received)
	health_C.died.connect(on_died)

func _physics_process(_delta: float) -> void:
	pass

# --------------------------------
# 共通処理
# --------------------------------

## 攻撃した
func on_attacked() -> void:
	print(self.name + "は攻撃した！")

## 自分の攻撃を当てた
func on_hitted(target: CollisionObject2D) -> void:
	print(self.name + "は" + target.name + "に攻撃を当てた")
	self.attack_C.hit(target)
	
## 相手の攻撃を受けた
func on_received(attacker: CollisionObject2D, damage: float, knockback: float) -> void:
	print(self.name + "は" + attacker.name + "から" + "%.0f" % damage + "のダメージを受けた")
	self.health_C.damage(attacker, damage)
	self.knockback_C.knockback(attacker, knockback)


## 死んだ
func on_died(attacker: CollisionObject2D) -> void:
	print(self.name + "は殺された")
	self.queue_free()

# --------------------------------
# 個別処理
# --------------------------------
