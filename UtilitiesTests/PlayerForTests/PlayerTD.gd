# Top-Down Player Implementation
extends Area2D

var mouseOver = false
var maxSteps = 6
var stepsLeft
var tileBelow
var playerSelected = false
var active = false

signal player_clicked(selected, node)
signal player_moved
signal turn_finished

func _ready():
    stepsLeft = maxSteps

func _process(delta):
    if active:
        if Input.is_action_just_pressed("left_click"):
            if mouseOver == true:
                playerSelected = !playerSelected
                emit_signal("player_clicked", playerSelected, self)

func finish_turn():
    active = false
    $Sprite.modulate = Color(1, 0.3, 0.3)
    set_z_index(1)
    reset_player_moves()
    
func set_active():
    active = true
    $Sprite.modulate = Color(0.5, 0.5, 0.25)
    set_z_index(2)
    
func get_player_steps_left():
    return stepsLeft
    
func move_player(destTile, steps):
    stepsLeft -= steps
    move_to_tile(destTile)
    emit_signal("player_moved")

func move_to_tile(tile):
    tileBelow = tile
    move_to_position(tile.position)

func move_to_position(newPos):
    position = newPos

func get_player_tile():
    return tileBelow

func reset_player_moves():
    stepsLeft = maxSteps
    playerSelected = false

func _on_PlayerTD_mouse_entered():
    mouseOver = true

func _on_PlayerTD_mouse_exited():
    mouseOver = false
