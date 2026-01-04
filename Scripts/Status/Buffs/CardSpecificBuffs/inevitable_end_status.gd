class_name InevitableEndStatus extends Status

func setup_Status(start_count : int, new_owner: Entities) -> Status:
    status_attributes = load(RESOURCE_PATH + "Buffs/CardSpecificBuffs/inevitable_end_status.tres")
    return super(start_count, new_owner)

func roundStart():

    for enemy in Global.tileManager.get_entities_within(owner.location, 2):
        for x in range(self.count):
            enemy.accelerateAllStatuses()
            if owner.hasStatus("Call of the Abyss"):
                enemy.accelerateAllStatuses()