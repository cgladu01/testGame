class_name EnemyActions

var imageIndicator: Array[String] = []
var numberIndicators: Array[int] = []
var owner: Enemy = null
var name: String = ""


func setup(owner: Enemy):
    self.owner = owner

func execute():
    pass
