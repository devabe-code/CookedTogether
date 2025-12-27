extends CharacterBody3D
class_name CharacterBase

#@export var model : CharacterBody3D
#@export var healthbar : ProgressBar
#@export var health : int
#var invincible : bool = false
#var is_dead : bool = false

func _ready():
	init_character()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float):
	pass
	
#Add anything here that needs to be initialized on the character
func init_character():
	pass
	#healthbar.max_value = health
	#healthbar.value = health

#region Taking Damage
#Play universal damage sound effect for any character taking damage and flashing red
#func damage_effects():
	#pass
#
##After we are done flashing red, we can take damage again
#func after_damage_iframes():
	#invincible = true
	#var tween = create_tween()
	#tween.tween_property(self, "modulate", Color.DARK_RED, 0.1)
	#tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	#tween.tween_property(self, "modulate", Color.RED, 0.1)
	#tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	#await tween.finished
	#invincible = false
	#
#func _take_damage(amount):
	#if(invincible == true || is_dead == true):
		#return
		#
	#health -= amount
	#healthbar.value = health;
	#damage_effects()
	#
	#if(health <= 0):
		#_die()
		#
#func _die():
	#if(is_dead):
		#return
		#
	#is_dead = true
	##Remove/destroy this character once it's able to do so unless its the player
	#await get_tree().create_timer(1.0).timeout
	#if is_instance_valid(self) and not is_in_group("Player"):
		#queue_free()

#endregion
