class_name StartOfRoundHap extends "res://Scripts/Hap/Hap.gd"

var round : int = 0
func setup_StartOfRoundHap(round: int):
	self.round = round
	self.description = str("Begining of round ", self.round, ".")

