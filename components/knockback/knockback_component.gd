@icon("res://components/knockback/knockback_icon.png")
class_name KnockbackComponent extends Component
## ノックバックの機能を追加する。

# シグナル＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

## 自分がノックバックを受けたとき
signal knockbacked(attacker: CollisionObject2D, knockback: float)

# プロパティ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ノード参照－－－－－－－－－－－－－－－－－－－

# インスペクタ変数－－－－－－－－－－－－－－－－

# 状態変数－－－－－－－－－－－－－－－－－－－－

# メソッド＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# ライフサイクルメソッド－－－－－－－－－－－－－

func _ready() -> void:
	super._ready()

# 外部呼出メソッド－－－－－－－－－－－－－－－－

## ノックバックを受ける処理
func knockback(attacker: CollisionObject2D, knockback: float) -> void:
	var direction = (host.global_position - attacker.global_position).normalized()
	for child in host.get_children():
		if child is not MoveComponent:
			continue
		child.force_add_velocity(direction * knockback)
		return
	

# 内部処理メソッド－－－－－－－－－－－－－－－－

# シグナルメソッド－－－－－－－－－－－－－－－－
