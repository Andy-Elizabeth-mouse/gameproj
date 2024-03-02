extends RichTextLabel

var count = 0

func _ready():
	self.text = "0"

func _on_pressed():
	count += 1
	self.text = str(count)
