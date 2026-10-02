@abstract class_name Component extends Node
## 全てのコンポーネントの共通抽象親クラス

var host: CollisionObject2D

func _ready() -> void:
	host = get_parent() as CollisionObject2D
	if host : print("ready:コンポーネント接続成功 : [" + host.name + "]" + name)
	assert(
		host != null,
		"%s の親ノードは CollisionObject2D である必要があります。" % name
	)
