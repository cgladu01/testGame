class_name PatternNode

var up : PatternNode = null
var right : PatternNode = null
var left : PatternNode = null
var down : PatternNode = null
var behavior : Callable = func (): print("uhhh")
var select : bool = true
var previous : Vector2i = Vector2i(3, 12)

func setup(initial_behavior : Callable, up : PatternNode = null, right: PatternNode = null, down : PatternNode = null, left : PatternNode = null):
    behavior = initial_behavior

    self.up = up
    if up != null:
        up.down = self

    self.right = right
    if right != null: 
        right.left = self

    self.down = down
    if down != null:
        down.up = self

    self.left = left
    if left != null:
        left.right = self

func hover_event(starting_tile : Vector2i, rotation : int, unhover: bool = false, visited: Array[PatternNode] = []):    
    if visited.has(self):
        return
    else:
        visited.append(self)


    if select and not unhover:
        previous = Global.selectionTile.get_cell_atlas_coords(starting_tile)
        Global.selectionTile.set_cell(starting_tile, 11, Vector2i(3,0))
    elif select and unhover:
        Global.selectionTile.set_cell(starting_tile, 11, previous)

    match rotation:
        0:
            if up != null:
                up.hover_event(starting_tile + Vector2i(0, 1), rotation, unhover, visited)
            if right != null:
                right.hover_event(starting_tile + Vector2i(1, 0), rotation, unhover, visited)
            if down != null:
                down.hover_event(starting_tile + Vector2i(0, -1), rotation, unhover, visited)
            if left != null:
                left.hover_event(starting_tile + Vector2i(-1, 0), rotation, unhover, visited)
        1:
            if up != null:
                up.hover_event(starting_tile + Vector2i(1, 0), rotation, unhover, visited)
            if right != null:
                right.hover_event(starting_tile + Vector2i(0, -1), rotation, unhover, visited)
            if down != null:
                down.hover_event(starting_tile + Vector2i(-1, 0), rotation, unhover, visited)
            if left != null:
                left.hover_event(starting_tile + Vector2i(0, 1), rotation, unhover, visited)
        2:
            if up != null:
                up.hover_event(starting_tile + Vector2i(0, -1), rotation, unhover, visited)
            if right != null:
                right.hover_event(starting_tile + Vector2i(-1, 0), rotation, unhover, visited)
            if down != null:
                down.hover_event(starting_tile + Vector2i(0, 1), rotation, unhover, visited)
            if left != null:
                left.hover_event(starting_tile + Vector2i(1, 0), rotation, unhover, visited)
        3:
            if up != null:
                up.hover_event(starting_tile + Vector2i(-1, 0), rotation, unhover, visited)
            if right != null:
                right.hover_event(starting_tile + Vector2i(0, 1), rotation, unhover, visited)
            if down != null:
                down.hover_event(starting_tile + Vector2i(1, 0), rotation, unhover, visited)
            if left != null:
                left.hover_event(starting_tile + Vector2i(0, -1), rotation, unhover, visited)
        
    # Breadth first for handling patterns
    # Rotation 0 : 0,  1 : 90, 2 : 180, 3 : 270 
func proccess_event(starting_tile : Tile, rotation : int = 0, visited : Array[PatternNode] = []):
    if visited.has(self):
        return
    else:
        visited.append(self)
    
    behavior.call(starting_tile)

    match rotation:
        0:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation, visited)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation, visited)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation, visited)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation, visited)
        1:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation, visited)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation, visited)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation, visited)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation, visited)
        2:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation, visited)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation, visited)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation, visited)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation, visited)
        3:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation, visited)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation, visited)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation, visited)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation, visited)
        
