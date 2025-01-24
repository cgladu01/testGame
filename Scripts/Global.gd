extends Node

# RNG for use in Enemy Action selection
var rng : RandomNumberGenerator = null

# Is an action selected and what is that action
var selection : bool = false
var currentAction : Action = null
func actionSelection(selected_action: Action):
	confirmationWindow.emit()
	selectionTile.clear()
	selection = !selection
	currentAction = selected_action

# Impassable Objects on the board. Not used rn.
var impassableList = []

# Represents the board
var tileshift : Vector2 = Vector2(1,1)
var tileShift : Vector2i = Vector2i(1, 1)
var tileManager: TileManager = TileManager.new()
var selectionTile : TileMapLayer

# Factories that make elements to be used in gameplay
var statusFactory : StatusFactory = StatusFactory.new()
var characterFactory : CharacterFactory = CharacterFactory.new()
var actionFactory: ActionFactory = ActionFactory.new()
var enemyFactory : EnemyFactory = EnemyFactory.new()
var hapFactory : HapFactory = HapFactory.new()

# Node that holds all other units
var unitsNode = null 

# Arrays of characters and enemies
var characters : Array[Character] = []
var enemies : Array[Enemy] = []

# Updates the energy shown in the bottom left
signal update_energy

# Brings up confirmation window
signal confirmationWindow

#Signals for combat effects
signal combatStart
signal combatEnd
signal roundStart
signal roundEnd

#Signal For an entities death
signal entityDeath

#Signal for characterdeath
signal characterDeath

# Is the log container in the bottom right of screen
var log_container

