extends PathFollow2D

export (float) var SPEED = 200
export (float) var MAX_OFFSET = 32

func _ready():
    $Sprite.position.y += rand_range(-MAX_OFFSET, MAX_OFFSET)

func _physics_process(delta):
    offset += SPEED * delta
    
    if unit_offset >= 1:
        queue_free()