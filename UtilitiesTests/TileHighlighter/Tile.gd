extends Node2D

signal path_tile_clicked(tileNode)

var sprite_size = 16
onready var highlighted = false
onready var parentInTree = null
onready var hasParent = false
onready var level = 9999

var posx
var posy
var mouseInside = false

signal path_tile_mouse_entered(node)


func _ready():
    $Sprite.show()
    $Sprite/Label.hide()

func _process(delta):
    if Input.is_action_just_pressed("left_click"):
        if mouseInside && highlighted:
            emit_signal("path_tile_clicked", self)

# x = row, y = column, position in X is defined by its columns number
func calculate_position(x,y):
    position.x = y*sprite_size
    position.y = x*sprite_size
    posx = x
    posy = y

func highlight():
    highlighted = true
    highlight_sprite()
    
func remove_highlight():
    highlighted = false
    level = 9999
    hasParent = false
    parentInTree = null
    revert_sprite()
    distance_hide()

func highlight_sprite():
    $Sprite.modulate = Color(0, 0, 1)

func revert_sprite():
    $Sprite.modulate = Color(1, 1, 1)

func is_highlighted():
    return highlighted

func get_x():
    return posx
    
func get_y():
    return posy
    
func set_parent(pNode):
    if (!hasParent):
        parentInTree = pNode
        hasParent = true

func get_parent():
    return parentInTree
    
#func starting():
#    differentColor = true

func change_level(new_level):
    level = new_level
    $Sprite/Label.text = String(level)
    
func get_level():
    return level

func _on_Tile_mouse_entered():
    if (highlighted):
        mouseInside = true
        emit_signal("path_tile_mouse_entered", self)        

func _on_Tile_mouse_exited():
    if (highlighted):
        mouseInside = false       

func movement_highlight():
    $Sprite.modulate = Color(1, 1, 0)

func distance_show():
    $Sprite/Label.show()
    
func distance_hide():
    $Sprite/Label.hide()
    
func highlight_path():
    movement_highlight()
    distance_show()
    if (parentInTree != null):
        parentInTree.highlight_path()
    
func hide_path():
    highlight_sprite()
    distance_hide()
    if (parentInTree != null):
        return parentInTree.hide_path()
    return true