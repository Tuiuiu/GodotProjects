extends Node

onready var gridmap = $GridMap
onready var player = $PlayerTD

# Called when the node enters the scene tree for the first time.
func _ready():
    gridmap.connect("gridmap_started", self, "gridmap_started_handler")
    gridmap.connect("move_player_to_tile", self, "move_player_to_tile_handler")
    player.connect("player_clicked", self, "player_clicked_handler")
    gridmap.start_grid()

func gridmap_started_handler(gridHeight, gridWidth):
    randomize()
    var startX = randi()%gridHeight
    var startY = randi()%gridWidth
    var startingNode = gridmap.get_node_in_grid(startX, startY)
    # Tile position + grid offset
    player.move_to_tile(startingNode)
    
func player_clicked_handler(playerSelected):
    if (playerSelected):
        var steps = player.get_player_steps_left()
        gridmap.breadth_first_search(player.get_player_tile(), steps)
    else:
        gridmap.reset_highlights()
    
func move_player_to_tile_handler(destTile, destSteps):
    gridmap.reset_highlights()
    player.move_player(destTile, destSteps)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        gridmap.reset_highlights()
        player.reset_player_moves()
