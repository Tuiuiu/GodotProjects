extends Node

onready var gridmap = $GridMap
onready var player = $PlayerTD
onready var turnManager = $TurnManager
onready var camera = $Camera2D
onready var activeCharacter

# Called when the node enters the scene tree for the first time.
func _ready():
    gridmap.connect("gridmap_started", self, "gridmap_started_handler")
    gridmap.connect("move_player_to_tile", self, "move_player_to_tile_handler")
    turnManager.connect("turn_finished", self, "turn_finished_handler")
    gridmap.start_grid()

func gridmap_started_handler(gridHeight, gridWidth):
    randomize()
    for node in turnManager.get_children():
        var startX = randi()%gridHeight
        var startY = randi()%gridWidth
        var startingNode = gridmap.get_node_in_grid(startX, startY)
        # Tile position + grid offset
        node.move_to_tile(startingNode)
        node.connect("player_clicked", self, "player_clicked_handler")
        node.connect("player_moved", self, "player_moved_handler")
    turnManager.setup_existing_queue()
    turnManager.initialize()
    
func player_clicked_handler(playerSelected, playerNode):
    if (playerSelected):
        activeCharacter = playerNode
        var steps = activeCharacter.get_player_steps_left()
        gridmap.breadth_first_search(activeCharacter.get_player_tile(), steps)
    else:
        gridmap.reset_highlights()

func player_moved_handler():
    var steps = activeCharacter.get_player_steps_left()
    gridmap.reset_highlights()
    gridmap.breadth_first_search(activeCharacter.get_player_tile(), steps)
    
func move_player_to_tile_handler(destTile, destSteps):
    gridmap.reset_highlights()
    activeCharacter.move_player(destTile, destSteps)

func turn_finished_handler():
    gridmap.reset_highlights()
    