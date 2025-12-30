class_name SilentProtector extends Action

func setup(owner: Character):
    actionAttributes = load("res://Resources/Actions/Assassin/NoTargetAction/silent_protector.tres")
    cost = 2
    super(owner)

func button_pressed():
    Global.actionSelection(self)
    Global.selectionTile.markTiles(owner.location, 0, 4)

func execute():
    if canPlay():
        var status = Sanctuary.new().setup_Status(3, owner)
        for character in Global.tileManager.get_entities_within(owner.location, 3, 0):
            status.underTheSanctuary(character)
        
        super()
        owner.addStatus(Silence.new().setup_Status(2, owner), owner)
        owner.addStatus(status, owner)
        owner.discardDeck.insertAtFront(self)

