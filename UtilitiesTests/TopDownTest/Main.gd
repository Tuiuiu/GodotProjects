extends Node

onready var gridmap = $GridMap
onready var player = $PlayerTD

# Called when the node enters the scene tree for the first time.
func _ready():
    gridmap.connect("gridmap_started", self, "gridmap_started_handler")
    gridmap.start_grid()

func gridmap_started_handler(gridHeight, gridWidth):
    randomize()
    var startX = randi()%gridHeight
    var startY = randi()%gridWidth
    print(startX, startY)
    var startingNode = gridmap.get_node_in_grid(startX, startY)
    # Tile position + grid offset
    player.move_to_position(startingNode.position + gridmap.position)
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass