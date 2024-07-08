extends CanvasLayer


@onready var timer_label: Label = $TimerLabel
@onready var gold_label: Label = $Panel/GoldLabel
@onready var meat_label: Label = $Panel/MeatLabel



func _ready():
	GameManager.player.meat_collected.connect(on_meat_collected)
	meat_label.text = str(0)
	

func _process(delta: float):	
	timer_label.text = GameManager.time_elapsed_string

func on_meat_collected(regeneration_value: int) -> void:
	GameManager.meat_counter += 1
	meat_label.text = str(GameManager.meat_counter)
