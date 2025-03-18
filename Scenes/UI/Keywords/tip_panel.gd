class_name TipPanel extends PanelContainer

@onready var keywordName = $VBoxContainer/KeywordName
@onready var keywordText = $VBoxContainer/KeywordText

func setup(keyword : String, description : String): 
	keywordName.text = keyword
	keywordText.append_text(description)
