class_name SplinteringShield extends Action

func setup(owner: Character):

    actionAttributes = load("res://Resources/Actions/Druid/NoTargetAction/splintering_shield.tres")
    cost = 2
    super(owner)


func button_pressed():
    Global.actionSelection(self)

func execute():
    if canPlay():
        owner.gainBlock(10)
        owner.addStatus(SplinteringShieldStatus.new().setup_Status(6, owner), owner)
        super()
        owner.discardDeck.insertAtFront(self)