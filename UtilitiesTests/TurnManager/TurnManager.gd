extends Node

var activeCharacter

signal turn_finished

func _process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        activeCharacter.finish_turn()
        character_turn_finished()
        emit_signal("turn_finished")

func setup_existing_queue():
    for node in get_children():
        node.connect("turn_finished", self, "character_turn_finished")
        
func add_character_to_queue(node):
    node.connect("turn_finished", self, "character_turn_finished")
    add_child(node)
    pass
    
func initialize():
    activeCharacter = get_child(0)
    activeCharacter.set_active()
    
func character_turn_finished():
    var newIndex = (activeCharacter.get_index() + 1) % get_child_count()
    activeCharacter = get_child(newIndex)
    activeCharacter.set_active()