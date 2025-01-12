extends CardDropzone

@export var accept_element: String

func can_drop_card(card_ui: CardUI):
	return card_ui.card_data.element == accept_element
