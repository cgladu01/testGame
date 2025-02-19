class_name BearWitness extends Action

func setup(owner: Entities):
    name = "Bear Witness"
    description = "Inflict Call of the Abyss 4 on all enemies withing Range 3. Gain Call of the Abyss 5 if you do not have it, else decelerate it by 2."
    type = 1
    super(owner)

func button_pressed():
    Global.actionSelection(self)

func execute():
    if canPlay():
        print(Global.tileManager.get_entities_within(owner.location, 3))
    super()
