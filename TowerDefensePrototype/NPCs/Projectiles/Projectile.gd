extends Area2D

var target
var speed = 500
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
export (float) var damage = 1 
export var steer_force = 750.0

func start(_transform, _target):
    global_transform = _transform
    #velocity = transform.x * speed
    target = weakref(_target)
    velocity = (target.get_ref().position - position).normalized() * speed

func seek():
    var steer = Vector2.ZERO
    if(target.get_ref()):
        var desired = (target.get_ref().position - position).normalized() * speed
        steer = (desired - velocity).normalized() * steer_force
    return steer

func _physics_process(delta):
    
    if(!target.get_ref()):
        queue_free()    
    else:    
        #acceleration += seek()
        #velocity += acceleration * delta
        #velocity = velocity.clamped(speed)
        #rotation = velocity.angle()
        #position += velocity * delta
    
        var desired = (target.get_ref().position - position).normalized() * speed
        desired = desired.clamped(speed)
        rotation = desired.angle()
        position += desired * delta
        
func expire():
    yield(get_tree().create_timer(2), "timeout")
    queue_free()

func get_damage():
    return damage

func _on_Projectile_area_entered(area):
    if (area.is_in_group("Enemy")):
        var enemy = area.get_parent()
        if (enemy == target.get_ref()):
            enemy.take_damage(damage)
            queue_free()
