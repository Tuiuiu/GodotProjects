extends Node2D

export var cooldown = 0.5

var can_shoot = true
onready var nextShot = 0
onready var onCombat = false
onready var visibleEnemies = 0
onready var targets = []
var projectile = preload("res://NPCs/Projectiles/Projectile.tscn")


func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if (onCombat == true):
        shoot()  

func shoot():
    if can_shoot:
        for target in targets:
            var m = projectile.instance()
            m.start(self.global_transform, target)
            get_parent().add_child(m)
        can_shoot = false
        yield(get_tree().create_timer(cooldown), "timeout")
        can_shoot = true

#func find_target():
#    var units = get_overlapping_bodies()
#    if units.size() > 0:
#        var closest = units[0]
#        var existingEnemy = false
#        for unit in units:
#            if unit.is_in_group("Enemy") && position.distance_to(unit.global_position) < position.distance_to(closest.global_position):
#                closest = unit
#                existingEnemy = true
#        if (existingEnemy):
#            target = closest
#    else:
#        target = null

func _on_Tower_area_entered(area):
    if (area.is_in_group("Enemy")):
        visibleEnemies += 1
        targets.append(area.get_parent())
        onCombat = true


func _on_Tower_area_exited(area):
    if (area.is_in_group("Enemy")):
        visibleEnemies -= 1
        targets.erase(area.get_parent())
        if (visibleEnemies <= 0):
            onCombat = false
