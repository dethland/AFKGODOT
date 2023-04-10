extends TileMap

var map
const GRASS_TILE_SOURCE_ID = 2
const PROTO_TILE_SOURCE_ID = 0
const NAVI_TILE_ATLAS_ID = Vector2i(4,2)
const TOP_TILE_Y_CORD_1 = 0 # the line where should draw navi mesh on top
const TOP_TILE_Y_CORD_2 = 3 # the line where should draw navi mesh on top

func _ready():
	build_navigation()
	map = get_navigation_map(0)
	NS.navi_map = map
	
	
func build_navigation():
	for tile_cord in get_used_cells(0):
		var atlas_id = get_cell_atlas_coords(0, tile_cord)
		var head = get_neighbor_cell(tile_cord, TileSet.CELL_NEIGHBOR_TOP_SIDE)
		var head_atlas_id = get_cell_atlas_coords(0, head)
		var source_id = get_cell_source_id(0, tile_cord)
		
		if source_id == GRASS_TILE_SOURCE_ID:
			if atlas_id.y == TOP_TILE_Y_CORD_1 or atlas_id.y == TOP_TILE_Y_CORD_2:
				if head_atlas_id == Vector2i(-1, -1):
					set_cell(0, head, 2, NAVI_TILE_ATLAS_ID)
					
			
					
					
					
