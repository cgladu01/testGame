class_name EventOption extends RefCounted

var behavior : Callable = func (): print("Not Implemented")
var text : String = ""

func setup(n_text : String, n_behavior : Callable):
    text = n_text
    behavior = n_behavior