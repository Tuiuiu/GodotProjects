extends PathFollow2D

export (float) var SPEED = 200
export (float) var MAX_OFFSET = 32

signal end_of_path
var life

func _ready():
    $Area2D.position.y += rand_range(-MAX_OFFSET, MAX_OFFSET)
    life = 3

func _physics_process(delta):
    offset += SPEED * delta

    if (unit_offset >= 1):
        emit_signal("end_of_path")
        die()
        
func take_damage(damage):
    life = life - damage
    if (life <= 0):
        die()
        
func die():
    queue_free()

func _on_Area2D_area_entered(area):
    if (area.is_in_group("Projectile")):
        var damage = area.get_damage()
        area.queue_free()
        take_damage(damage)
