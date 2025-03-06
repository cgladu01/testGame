class_name SilentProtector extends Action

func setup(owner: Character):
    name = "Silent Protector"
    description = "Gain 30 Block. Gain Silenced 2. Gain Santuary 3."
    type = Global.card_type.SKILL
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

