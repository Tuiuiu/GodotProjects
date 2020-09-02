extends Node2D

signal path_tile_clicked(tileNode)

var sprite_size = 16
onready var highlighted = false
onready var parentInTree = null
onready var hasParent = false
onready var level = 0
onready var differentColor = false
var posx
var posy
var mouseInside = false

func _ready():
    $Sprite.show()
    $Sprite/Label.hide()

func _process(delta):
    if Input.is_action_just_pressed("left_click"):
        if mouseInside:
            emit_signal("path_tile_clicked", self)

func calculate_position(x,y):
    position.x = x*sprite_size
    position.y = y*sprite_size
    posx = x
    posy = y
    #print(position)

func highlight():
    highlighted = true
    highlight_sprite()
    
func remove_highlight():
    highlighted = false
    revert_sprite()

func highlight_sprite():
    if differentColor:
        $Sprite.modulate = Color(0, 1, 0)
    else:
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
    
func starting():
    differentColor = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func change_level(new_level):
    level = new_level
    $Sprite/Label.text = String(level)
    
func get_level():
    return level

func _on_Tile_mouse_entered():
    if (highlighted):
        mouseInside = true
        #$Sprite.modulate = Color(1, 1, 0)
        #$Sprite/Label.show()
        highlight_path()
    #highlight_path()

func _on_Tile_mouse_exited():
    if (highlighted):
        mouseInside = false
        #highlight_sprite()
        #$Sprite/Label.hide()
        hide_path()
    #hide_path()

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
    if (parentInTree != null):
        parentInTree.hide_path()