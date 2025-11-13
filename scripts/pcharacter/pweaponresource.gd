class_name pweaponres extends Resource

@export var NAME: String ## The name of the weapon
@export var SCENE: PackedScene ## The scene containing the weapon model
@export_category("Weapon Position")
@export var POSITION: Vector3 ## The position the weapon should have in the player's hands
@export var ROTATION: Vector3 ## The rotation the weapon should have in the player's hands
@export var SCALE: float = 1.0 ## The scale of the weapon in the player's hands
