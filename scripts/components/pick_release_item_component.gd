extends Node3D

var level: Level

var player: Player = null
var holding_item: bool = false
var item = null
var item_path: String = ""
@export var sprite_item: AnimatedSprite3D = null
@export var raycast: RayCast3D = null
@export var hand_animation: AnimatedSprite3D = null
@export var _inventory: Inventory = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Player:
		player = get_parent() as Player
		level = player.level
			
	#print("player owner: " +str(player.get_owner()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if holding_item:
		sprite_item.show()
		hand_animation.hide()
		_inventory.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		sprite_item.hide()
		hand_animation.show()
		_inventory.process_mode = Node.PROCESS_MODE_INHERIT
		
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction") and raycast.get_collider() and raycast.get_collider().is_in_group("item") and !holding_item:
		item = raycast.get_collider()
		item.linear_velocity = Vector3.ZERO
		item.angular_velocity = Vector3.ZERO
		item.process_mode = Node.PROCESS_MODE_DISABLED
		item.hide()
		
		if item is EnemyItem:
			sprite_item.play("satodrink")
		if item is ExplosionItem:
			sprite_item.play("barril")
			
		#print("holding item: " + str(item))
		holding_item = true

		
	if event.is_action_pressed("release_item") and holding_item:
		if item is ExplosionItem or item is EnemyItem:
			item.launched = true
		item.process_mode = Node.PROCESS_MODE_INHERIT
		item.global_position = sprite_item.global_position
		item.show()
		#print("item -raycast.global_basis.z: " + str(-raycast.global_basis.z))
		item.rotation = player.global_rotation
		item.apply_central_impulse(-raycast.global_basis.z * 10)

		item = null
		#print("holding item: " + str(item))
		holding_item = false
		level.launched_item()
