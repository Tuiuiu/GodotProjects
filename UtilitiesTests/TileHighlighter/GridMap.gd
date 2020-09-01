extends Node2D

var tileRes = preload("res://TileHighlighter/Tile.tscn")
var gridmap = []
var height = 16
var width = 16


func _ready():
    randomize()
    position = Vector2(64,64)
    start_grid(height, width)
    #print_grid()
    #gridmap[randi()%height][randi()%width].highlight()
    breadth_first_search(gridmap[randi()%height][randi()%width], 8)

func start_grid(x, y):
    for i in range(0, x):
        gridmap.append([])
        for j in range(y):
            var tile = tileRes.instance()
            tile.calculate_position(i,j)
            gridmap[i].append(tile)
            add_child(tile)
            
func print_grid():
    print(gridmap)

func breadth_first_search(starting_node, search_level):
    var search_root = starting_node
    var queue = []
    var actual_level = 0
    var count = 0
    var nextStop = 0
    queue.append(search_root)
    search_root.starting()
    nextStop = queue.size()
    #queue.append("break")
    
    for node in queue:
        if count == nextStop:
            actual_level += 1
            nextStop = queue.size()
            if actual_level >= search_level:
                break
        if !node.is_highlighted(): 
            node.highlight()
            #check neighbour
            var this_x = node.get_x()
            var this_y = node.get_y()
            if is_in_grid(this_x + 1, this_y):
                if !gridmap[this_x+1][this_y].is_highlighted():
                    queue.append(gridmap[this_x+1][this_y])
            if is_in_grid(this_x - 1, this_y):
                if !gridmap[this_x-1][this_y].is_highlighted():
                    queue.append(gridmap[this_x-1][this_y])
            if is_in_grid(this_x, this_y + 1):
                if !gridmap[this_x][this_y+1].is_highlighted():
                    queue.append(gridmap[this_x][this_y+1])
            if is_in_grid(this_x, this_y - 1):
                if !gridmap[this_x][this_y-1].is_highlighted():
                    queue.append(gridmap[this_x][this_y-1])
            count += 1
        else: 
            count += 1
        

       
func is_in_grid(x,y):
    return x >= 0 && x < height && y >= 0 && y < width

#BuscaEmLargura
#   escolha uma raiz s de G
#   marque s
#   insira s em F
#   enquanto F não está vazia faça
#      seja v o primeiro vértice de F
#      para cada w ∈ listaDeAdjacência de v faça
#         se w não está marcado então
#           visite aresta entre v e w
#           marque w
#           insira w em F
#         senao se w ∈ F entao
#           visite aresta entre v e w
#         fim se
#      fim para
#      retira v de F
#   fim enquanto
    