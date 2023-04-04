extends TileMap

var map

func _ready():
	build_navigation()
	map = get_navigation_map(0)
	NS.navi_map = map
	
	
func build_navigation():
	tile_set.get_source(0).create_alternative_tile(Vector2i(0,0), 1)
	for tile_cord in get_used_cells(0):
		var vec2_id = get_cell_atlas_coords(0, tile_cord)
		var head = get_neighbor_cell(tile_cord, TileSet.CELL_NEIGHBOR_TOP_SIDE)
		var head_vec2_id = get_cell_atlas_coords(0, head)
		match vec2_id:
			Vector2i(0, 0):
				if head_vec2_id == Vector2i(-1, -1):
					set_cell(0, head, 0, Vector2i(1,0))

			Vector2i(1,1):
				if head_vec2_id == Vector2i(-1, -1):
					set_cell(0, head, 0, Vector2i(1,0))
					
					
	for tile_cord in get_used_cells(0):
		var vec2_id = get_cell_atlas_coords(2, tile_cord)
		var head = get_neighbor_cell(tile_cord, TileSet.CELL_NEIGHBOR_TOP_SIDE)
		var head_vec2_id = get_cell_atlas_coords(0, head)
		match vec2_id:
			Vector2i(0, 0):
				if head_vec2_id == Vector2i(-1, -1):
					set_cell(0, head, 0, Vector2i(1,0))

			Vector2i(1,0):
				if head_vec2_id == Vector2i(-1, -1):
					set_cell(0, head, 0, Vector2i(1,0))
					
			Vector2i(2,0):
				if head_vec2_id == Vector2i(-1, -1):
					set_cell(0, head, 0, Vector2i(1,0))
					
