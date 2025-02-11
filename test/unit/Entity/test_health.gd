extends GutTest

var world = null
func before_all():
    world = load("res://Scenes/Maps/initial.tscn").instantiate()
    add_child(world)


func test_passes():
    var dudeman = Global.characters.front()
    var wolf = Global.characters.front()
    wolf.attack(10, dudeman)
    assert_eq(dudeman.get_health(), 30)
	
func after_all():
    world.queue_free()

    