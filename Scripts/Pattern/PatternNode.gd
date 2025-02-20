class_name PatternNode

var up : PatternNode = null
var right : PatternNode = null
var left : PatternNode = null
var down : PatternNode = null
var behavior : Callable = func (): print("uhhh")

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

# Breadth first for handling patterns
# Rotation 0 : 0,  1 : 90, 2 : 180, 3 : 270 
func proccess_event(starting_tile : Tile, rotation : int = 0):
    behavior.call(starting_tile)

    match rotation:
        0:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation)
        1:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation)
        2:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(1, 0)), rotation)
        3:
            if up != null:
                up.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation)

            if right != null:
                right.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, 1)), rotation)

            if down != null:
                down.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(-1, 0)), rotation)

            if left != null:
                left.proccess_event(Global.tileManager.get_tile_entity(starting_tile.location + Vector2i(0, -1)), rotation)
        