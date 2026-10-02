extends Control

@onready var world : Node2D = $World
@onready var sub_viewport_1 : Viewport = $Screen/SubViewportContainer1/SubViewport
@onready var sub_viewport_2 : Viewport = $Screen/SubViewportContainer2/SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sub_viewport_1.world_2d = world.get_world_2d()
	sub_viewport_2.world_2d = world.get_world_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
