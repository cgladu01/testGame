class_name KeywordText extends RichTextLabel


func _on_ready() -> void:
    pass
    
func _on_meta_hover_ended(meta:Variant) -> void:
    Global.keywordHandler.removeToolTip(str(meta))

func _on_meta_hover_started(meta:Variant) -> void:
    Global.keywordHandler.generateToolTip(str(meta), self)


