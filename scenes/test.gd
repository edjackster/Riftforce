extends Node2D


@onready var card_pile_ui := $CardPileUI
@onready var dropzones := [
	$DiscardDropzone,
	$AirDropzone,
	$CrystalDropzone,
	$DarknessDropzone,
	$EarthDropzone
]


func _ready():
	randomize()


func _on_draw_button_pressed():
	card_pile_ui.draw(1)


func _on_draw_3_button_pressed():
	card_pile_ui.draw(3)


func _on_discard_hand_button_pressed():
	for card_ui in card_pile_ui.get_cards_in_pile(CardPileUI.Piles.hand_pile):
		card_pile_ui.set_card_pile(card_ui, CardPileUI.Piles.discard_pile)


func _on_discard_random_button_pressed():
	var hand_pile_size = card_pile_ui.get_card_pile_size(CardPileUI.Piles.hand_pile)
	if hand_pile_size:
		var random_card_in_hand = card_pile_ui.get_card_in_pile_at(CardPileUI.Piles.hand_pile, randi() % hand_pile_size)
		card_pile_ui.set_card_pile(random_card_in_hand, CardPileUI.Piles.discard_pile)


func _on_sort_button_pressed():
	card_pile_ui.sort_hand(func(a, b):
		if a.card_data.suit == b.card_data.suit:
			return a.card_data.value < b.card_data.value
		else:
			return a.card_data.element < b.card_data.element
	)


func _on_reset_button_pressed():
	card_pile_ui.reset()


func _on_remove_random_card_button_pressed():
	var hand_pile_size = card_pile_ui.get_card_pile_size(CardPileUI.Piles.hand_pile)
	if hand_pile_size:
		var random_card_in_hand = card_pile_ui.get_card_in_pile_at(CardPileUI.Piles.hand_pile, randi() % hand_pile_size)
		card_pile_ui.remove_card_from_game(random_card_in_hand)


func _on_discard_top_card_from_dropzones_button_pressed():
	for dropzone in dropzones:
		var top_card_in_dropzone = dropzone.get_top_card()
		if top_card_in_dropzone:
			card_pile_ui.set_card_pile(top_card_in_dropzone, CardPileUI.Piles.discard_pile)


func _on_return_random_discard_button_pressed():
	var discard_pile_size = card_pile_ui.get_card_pile_size(CardPileUI.Piles.discard_pile)
	if discard_pile_size:
		var random_card_in_discard = card_pile_ui.get_card_in_pile_at(CardPileUI.Piles.discard_pile, randi() % discard_pile_size)
		card_pile_ui.set_card_pile(random_card_in_discard, CardPileUI.Piles.hand_pile)
