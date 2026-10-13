class_name Projectile extends Area2D

# ----------------------------------------------------------------

var owner_entity: Entity
var start_position: Vector2

var speed: float
var range: float

# ----------------------------------------------------------------

func _ready() -> void:
	self.area_entered.connect(_area_entered)

func _physics_process(delta: float) -> void:
	self.global_position += Vector2.from_angle(rotation) * speed * delta
	if global_position.distance_to(start_position) >= range:
		destroy()

func _area_entered(area: Area2D):
	var attack_receiver: AttackReceiverComponent = area.get_parent() as AttackReceiverComponent
	if attack_receiver == null or attack_receiver.host == owner_entity:
		return
	var entity := attack_receiver.host
	if entity and entity != owner_entity:
		hit(entity)

# ----------------------------------------------------------------

## インスタンス時呼び出す初期化処理
func setup(owner: Entity, pos: Vector2, dir: Vector2, speed: float, range: float) -> void:
	self.global_position = pos
	self.rotation = dir.angle()
	self.owner_entity = owner
	self.start_position = pos
	
	self.speed = speed
	self.range = range

## 命中時の処理
func hit(target: Entity) -> void:
	destroy()

## 消滅時の処理
func destroy() -> void:
	queue_free()
