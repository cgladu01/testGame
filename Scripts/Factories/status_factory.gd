class_name StatusFactory

func createStatus(name: String, count: int) -> Status:
	var status : Status = null
	match name:
		"Bleed":
			status = Bleed.new()
		
		"Daze":
			status = Daze.new()
		_:
			status = Status.new()
			
	return status
