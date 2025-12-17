class_name BearWitness extends Action

func setup(owner: Character):
    actionAttributes = load("res://Resources/Actions/Soldier/NoTargetAction/bear_witness.tres")
    cost = 2
    super(owner)

func button_pressed():
    Global.actionSelection(self)
    Global.selectionTile.markTiles(owner.location, 0, 4)

func execute():
    if canPlay():
        for enemy in Global.tileManager.get_entities_within(owner.location, 3):
            enemy.addStatus(CallOfTheAbyss.new().setup_Status(4, enemy), owner)
        
        if owner.hasStatus("Call of the Abyss") == null:
            owner.addStatus(CallOfTheAbyss.new().setup_Status(5, owner), owner)
        else:
            owner.hasStatus("Call of the Abyss").incrementCount(2)
        
        owner.discardDeck.insertAtFront(self)


        super()
