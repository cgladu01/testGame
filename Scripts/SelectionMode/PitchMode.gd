class_name  PitchMode extends "res://Scripts/SelectionMode/SelectionMode.gd" 


func onConfirm():
	super()
	for action in selected:
		character.combatDeck.insertAtBack(action)
		character.hand.removeAction(action)
	character.handleDraw(selected.size())
	Global.update_hand.emit()
	selected.clear() 
