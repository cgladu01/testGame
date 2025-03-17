class_name KeywordText extends RichTextLabel


func _on_ready() -> void:
    append_text("[url=Hello]Example text[/url]")

func _on_meta_hover_ended(meta:Variant) -> void:
    Global.keywordHandler.removeTooltip(str(meta))

func _on_meta_hover_started(meta:Variant) -> void:
    Global.keywordHandler.generateTooltip(str(meta), self)


