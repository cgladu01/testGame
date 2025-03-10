class_name TileTypeReader

# This class only exists to prevent bloat in tileManager so
# It deos that by moving the tile types to here.



# Empty Tiles
var emptyTileDict = {
	4: [Vector2i(5, 3), Vector2i(0, 6), Vector2i(7,0), Vector2i(5,2), Vector2i(0,3)]

}
# Obstacle Tiles
var obstacleTileDict = {
	4: [Vector2i(6,2)]
}


# Note all other tiles will be null and be considered in part of the map.

func getTileType(source_id: int, atlas_cord: Vector2i) -> Tile:
	var newTile = null

	if source_id in emptyTileDict and atlas_cord in emptyTileDict[source_id]:
		newTile = EmptyTile.new()
		print(atlas_cord)
	elif source_id in emptyTileDict and atlas_cord in obstacleTileDict[source_id]:
		newTile = Obstacle.new()
	
	return newTile
		
