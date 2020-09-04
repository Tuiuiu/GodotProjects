extends Node2D

var tileRes = preload("res://TileHighlighter/Tile.tscn")
var gridmap = []
var height = 16
var width = 16
var movementDistance = 8
var lastTileHovered = null


signal gridmap_started(gridHeight, gridWidth)
signal move_player_to_tile(tile, steps)

func _ready():
    position = Vector2(0,0)
    #start_grid(height, width)
    #print_grid()
    #gridmap[randi()%height][randi()%width].highlight()
    #breadth_first_search(gridmap[randi()%height][randi()%width], movementDistance)

func start_grid():
    for i in range(0, height):
        gridmap.append([])
        for j in range(width):
            var tile = tileRes.instance()
            tile.calculate_position(i,j)
            gridmap[i].append(tile)
            add_child(tile)
            tile.connect("path_tile_clicked", self, "handle_tile_click")
            tile.connect("path_tile_mouse_entered", self, "path_tile_mouse_entered_handle")
    emit_signal("gridmap_started", height, width)
    
func path_tile_mouse_entered_handle(node):
    if lastTileHovered != null:
        var result = lastTileHovered.hide_path()
        if result is GDScriptFunctionState:
            result = yield (result, "completed")
    lastTileHovered = node
    node.highlight_path()
  
func print_grid():
    print(gridmap)

func breadth_first_search(starting_node, search_level):
    var search_root = starting_node
    var queue = []
    var actual_level = 0
    var count = 0
    var nextStop = 0
    var lastNode = null
    queue.append(search_root)
    #search_root.starting()
    nextStop = queue.size()
    #queue.append("break")
    
    for node in queue:
        if count == nextStop:
            actual_level += 1
            nextStop = queue.size()
            if actual_level >= search_level:
                break
        if !node.is_highlighted(): 
            node.change_level(actual_level)
            node.highlight()
            node.set_parent(lastNode)
            #check neighbour
            var this_r = node.get_r()
            var this_c = node.get_c()
            var nextNode
            if is_in_grid(this_r + 1, this_c):
                if !gridmap[this_r+1][this_c].is_highlighted():
                    nextNode = gridmap[this_r+1][this_c]
                    queue.append(nextNode)
                    nextNode.set_parent(node)
            if is_in_grid(this_r - 1, this_c):
                if !gridmap[this_r-1][this_c].is_highlighted():
                    nextNode = gridmap[this_r-1][this_c]
                    queue.append(nextNode)
                    nextNode.set_parent(node)
            if is_in_grid(this_r, this_c + 1):
                if !gridmap[this_r][this_c+1].is_highlighted():
                    nextNode = gridmap[this_r][this_c+1]
                    queue.append(nextNode)
                    nextNode.set_parent(node)
            if is_in_grid(this_r, this_c - 1):
                if !gridmap[this_r][this_c-1].is_highlighted():
                    nextNode = gridmap[this_r][this_c-1]
                    queue.append(nextNode)
                    nextNode.set_parent(node) 
        count += 1
        
func get_node_in_grid(h, w):
    return gridmap[h][w]
       
func is_in_grid(x, y):
    return x >= 0 && x < height && y >= 0 && y < width

func reset_highlights():
    for node in get_children():
        node.remove_highlight()

func handle_tile_click(node):
    emit_signal("move_player_to_tile", node, node.get_level())
    
    