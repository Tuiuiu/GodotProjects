extends Node2D

var sprite_size = 16
var highlighted = false
var posx
var posy
var differentColor = false

func _ready():
    $Sprite.show()
    pass # Replace with function body.

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
    
func starting():
    differentColor = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
