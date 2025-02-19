class_name BearWitness extends Action

func setup(owner: Entities):
    name = "Bear Witness"
    description = "Inflict Call of the Abyss 4 on all enemies withing Range 3. Gain Call of the Abyss 5 if you do not have it, else decelerate it by 2."
    type = 1
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


    super()
