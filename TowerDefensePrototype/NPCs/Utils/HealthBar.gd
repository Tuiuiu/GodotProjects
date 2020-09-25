extends Node2D

var bar_red = preload("res://NPCs/Utils/barHorizontal_red.png")
var bar_green = preload("res://NPCs/Utils/barHorizontal_green.png")
var bar_yellow = preload("res://NPCs/Utils/barHorizontal_yellow.png")

onready var healthbar = $HealthBar

func _ready():
    hide()

func _process(delta):
    global_rotation = 0

func set_max_value(value):
    healthbar.max_value = value

func update_healthbar(value):
    healthbar.texture_progress = bar_green
    if value < healthbar.max_value * 0.7:
        healthbar.texture_progress = bar_yellow
    if value < healthbar.max_value * 0.35:
        healthbar.texture_progress = bar_red
    if value < healthbar.max_value:
        show()
    healthbar.value = value