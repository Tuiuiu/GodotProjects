extends Node2D

export (float) var remainingLifes = 20

onready var levelCreep = preload("res://NPCs/Enemies/GenericEnemy.tscn")
onready var path = $Path2D

func _ready():
    pass # Replace with function body.

func end_of_path_handler():
    remainingLifes -= 1;
    print("Remainign Lifes: ", remainingLifes)
    if (remainingLifes <= 0):
        end_map()
        
func end_map():
    print("DERROTA!")
    Engine.time_scale = 0.5

func _on_SpawnTimer_timeout():
    var clone = levelCreep.instance()
    clone.connect("end_of_path", self, "end_of_path_handler")
    path.add_child(clone)

