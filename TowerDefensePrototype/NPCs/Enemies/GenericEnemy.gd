extends PathFollow2D

export (float) var SPEED = 200
export (float) var MAX_OFFSET = 32

signal end_of_path
onready var maxHealth = 3
onready var healthBar = $HealthDisplay
var currentLife

func _ready():
    #var randOffset = rand_range(-MAX_OFFSET, MAX_OFFSET)
    #$Area2D.position.y += randOffset
    #healthBar.position.y += randOffset
    currentLife = maxHealth
    healthBar.set_max_value(maxHealth)
    healthBar.update_healthbar(currentLife)

func _physics_process(delta):
    offset += SPEED * delta

    if (unit_offset >= 1):
        emit_signal("end_of_path")
        die()
        
func take_damage(damage):
    currentLife = currentLife - damage
    healthBar.update_healthbar(currentLife)
    if (currentLife <= 0):
        die()
        
func die():
    queue_free()

func get_max_health():
    return maxHealth
