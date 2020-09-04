extends Node

onready var gridmap = $GridMap
onready var player = $PlayerTD

# Called when the node enters the scene tree for the first time.
func _ready():
    gridmap.connect("gridmap_started", self, "gridmap_started_handler")
    player.connect("player_clicked", self, "player_clicked_handler")
    gridmap.start_grid()

func gridmap_started_handler(gridHeight, gridWidth):
    randomize()
    var startX = randi()%gridHeight
    var startY = randi()%gridWidth
    print(startX, startY)
    var startingNode = gridmap.get_node_in_grid(startX, startY)
    # Tile position + grid offset
    player.move_to_tile(startingNode)
    
func player_clicked_handler(playerSelected):
    if (playerSelected):
        var steps = player.get_player_steps_left()
        gridmap.breadth_first_search(player.get_player_tile(), player.get_player_steps_left())
    else:
        gridmap.reset_highlights()
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
