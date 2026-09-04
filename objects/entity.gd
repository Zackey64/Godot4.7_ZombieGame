class_name Entity extends CharacterBody2D

@onready var body: Sprite2D = $Body
@onready var head: Sprite2D = $Head

@onready var move_C: MoveComponent = $MoveComponent
@onready var direction_C: DirectionComponent = $DirectionComponent
@onready var health_C: HealthComponent = $HealthComponent 
@onready var attack_C: AttackComponent = $AttackComponent 

# --------------------------------
# ライフサイクル
# --------------------------------

func _ready() -> void:
	attack_C.attacked.connect(on_attacked)
	attack_C.hitted.connect(on_attack_hit)
	health_C.hitted.connect(on_damage_hit)
	health_C.damaged.connect(on_damaged)
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
func on_attack_hit(target: CollisionObject2D) -> void:
	print(self.name + "は" + target.name + "に攻撃を当てた")
	self.attack_C.attack(target)

## 相手の攻撃を受けた
func on_damage_hit(target: CollisionObject2D, amount: float) -> void:
	print(self.name + "は" + target.name + "から攻撃を受けた")
	self.health_C.damage(amount)

## ダメージを受けた
func on_damaged(amount: float) -> void:
	print(self.name + "は" + "%.0f" % amount + "のダメージ！")

## 死んだ
func on_died() -> void:
	print(self.name + "は殺された")

# --------------------------------
# 個別処理
# --------------------------------
