# Top-Down Player Implementation
extends Area2D

var mouseOver = false
var maxSteps = 6
var stepsLeft
var tileBelow
var playerSelected = false

signal player_clicked(selected)

func _ready():
    stepsLeft = maxSteps

func _process(delta):
    if Input.is_action_just_pressed("left_click"):
        if mouseOver == true:
            playerSelected = !playerSelected
            emit_signal("player_clicked", playerSelected)

func move_to_position(newPos):
    position = newPos

func move_to_tile(tile):
    tileBelow = tile
    move_to_position(tile.position)
    
func get_player_steps_left():
    return stepsLeft
    
func move_player(destTile, steps):
    stepsLeft -= steps
    move_to_tile(destTile)
    emit_signal("player_clicked", playerSelected)

func get_player_tile():
    return tileBelow

func reset_player_moves():
    stepsLeft = maxSteps
    playerSelected = false

func _on_PlayerTD_mouse_entered():
    mouseOver = true

func _on_PlayerTD_mouse_exited():
    mouseOver = false
