extends Node3D

var player: Player = null
var holding_item: bool = false
var item: StaticBody3D = null
var item_path: String = ""
@export var sprite_item: AnimatedSprite3D = null
@export var raycast: RayCast3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Player:
		player = get_parent() as Player
			
	#print("player owner: " +str(player.get_owner()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if holding_item:
		sprite_item.show()
	else:
		sprite_item.hide()
		
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction") and raycast.get_collider() and raycast.get_collider().is_in_group("item") and !holding_item:
		item = raycast.get_collider() as StaticBody3D
		item.global_position.y = 10
		print("holding item: " + str(item))
		holding_item = true

		
	if event.is_action_pressed("release_item") and holding_item:
		item.global_position = sprite_item.global_position
		item.show()
		item = null
		print("holding item: " + str(item))
		holding_item = false
