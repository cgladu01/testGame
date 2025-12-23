class_name Howl extends EnemyActions
const  BASE_STRENGTH_GAIN = 0
const BASE_SHIELD_GAIN = 1

func execute():
	owner.gainBlock(self.numberIndicators[BASE_SHIELD_GAIN])
	var buff = Strength.new()
	buff.setup_Status(self.numberIndicators[BASE_STRENGTH_GAIN], owner)
	owner.addStatus(buff, owner)
	
