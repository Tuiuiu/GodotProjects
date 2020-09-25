extends Node2D

var bar_darkred = preload("res://NPCs/Utils/barHorizontal_darkred.png")
var bar_red = preload("res://NPCs/Utils/barHorizontal_red.png")
var bar_green = preload("res://NPCs/Utils/barHorizontal_green.png")
var bar_yellow = preload("res://NPCs/Utils/barHorizontal_yellow.png")

onready var healthbar = $HealthBar

func _ready():
    #hide()
    pass

func _process(delta):
    global_rotation = 0
    
func start(maxvalue, curvalue):
    set_max_value(maxvalue)
    update_healthbar(curvalue)

func set_max_value(value):
    healthbar.max_value = value

func update_healthbar(value):
    healthbar.texture_progress = bar_green
    if value < healthbar.max_value * 0.75:
        healthbar.texture_progress = bar_yellow
    if value < healthbar.max_value * 0.5:
        healthbar.texture_progress = bar_red
    if value < healthbar.max_value * 0.25:
        healthbar.texture_progress = bar_darkred
    if value < healthbar.max_value:
        show()
    healthbar.value = value