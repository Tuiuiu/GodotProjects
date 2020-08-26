extends Node

# Playable Levels
var levels_array = []
var selected_level = 0
var active_level

# Interactive/Menu levels
var menus_array

# Called when the node enters the scene tree for the first time.
func _ready():
    active_level = null
    add_level(preload("res://LevelSelector/ExampleScene.tscn"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if (Input.is_action_just_pressed("ui_accept")):
        start_level()

# Add a new level to the array of available levels
func add_level(resource) -> void:
    levels_array.append(resource)

func exists_level(level_number : int) -> bool:
    if (levels_array.size() < level_number && level_number >= 0):
        return true
    else:
        return false

func start_level():
    active_level = levels_array[selected_level].instance()
    clear_level()
    add_child(active_level)
    
func play_next_level():
    change_level(selected_level + 1)
    if (exists_level(selected_level)):
        start_level()
    
func clear_level():
    for children in get_children():
        children.queue_free()
    
func change_level(level_number : int) -> void:
    selected_level = level_number
    
#func connect_to_child():
    #active_level.connect("next_level", self, "play_next_level")
    #active_level.connect("start_level", self, "play_next_level")
    #active_level.connect("next_level", self, "play_next_level")
    