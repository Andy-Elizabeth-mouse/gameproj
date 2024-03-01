extends RichTextLabel

func _process(_delta):
	var go = get_node("../Button")
	text = str(go.count)
