extends GutTest

func test_passes():
	var world = load("res://Scenes/Maps/initial.tscn").instantiate()

	await wait_seconds(5)

	var dudeman = Global.characters.front()
	var wolf = Global.characters.front()
	wolf.attack(10, dudeman)

	assert_eq(dudeman.get_health(), 40)



	
