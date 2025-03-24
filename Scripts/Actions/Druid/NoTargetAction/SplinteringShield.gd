class_name SplinteringShield extends Action

func setup(owner: Character):
    name = "Splintering Shield"
    description = "Gain 10 block. If an attacks breaks your block, deal 6 damage to all adjacent enemies."
    cost = 2
    type = Global.card_type.SKILL
    super(owner)


func button_pressed():
    Global.actionSelection(self)

func execute():
    if canPlay():
        owner.gainBlock(10)
        owner.addStatus(SplinteringShieldStatus.new().setup_Status(6, owner), owner)
        super()
        owner.discardDeck.insertAtFront(self)