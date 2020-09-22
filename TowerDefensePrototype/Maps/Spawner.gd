extends Path2D

func _on_Timer_timeout():
    var creep = preload("res://NPCs/Enemies/GenericEnemy.tscn").instance()
    add_child(creep)
