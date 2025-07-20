class_name SelectionMode

# Number of cards to select. 0 is unbounded
var count = 0
var selected: Array[Action] = []
var character: Character = null
signal updateOrder
signal end

func setup(selected_character: Character):
    character = selected_character

func selectedAction(action: Action):
    
    if action in selected:
        selected.erase(action)
    else:
        if selected.size() + 1 > count and count != 0:
            selected.pop_front()
        selected.push_back(action)
    
    updateOrder.emit()

func getIndex(action: Action) -> int:
    return selected.find(action) + 1

func onConfirm():
    end.emit()
    pass

func onDecline():
    end.emit()