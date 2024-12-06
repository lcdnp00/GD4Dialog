extends Node2D

var res : Vector2i = DisplayServer.window_get_size()

@export_category("Text")
@export var text : String
@export var text_speed : float = 0.002
@export var text_speedup_ratio : float = 20.0
var sped_up : bool = false
@export var visible_ratio_at_start : float = 0.0
@export var speedup_button : StringName = "txt_spd"
@export_category("Format")
@export var bold : bool
@export var italics : bool
@export var font_size : int
@export var colour : String
#@export var other BBCode options

@export_category("Panel")
@export var x : int
@export var y : int
@export var pos_x : int
@export var pos_y : int
@export var transparency : float = 1.0

@export_category("Effects")
@export var shake : float #TODO: implement this and other funky stuff maybe


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$Panel/Text.visible_ratio = visible_ratio_at_start

func set_text():
	set_text_content(text)
	set_text_speed(text_speed)

func set_text_content(txt: String):
	if $Panel/Text.text != txt:
		$Panel/Text.text = txt

func format_text():
	pass
	# TODO: set BBCode properties of the text. Do img and size first, discard the rest if it is img

func set_text_speed(txt_spd: float):
	if text_speed != txt_spd:
		text_speed = txt_spd

func set_panel():
	set_panel_size(x, y)
	set_panel_pos(pos_x, pos_y)
	set_panel_transparency(1.0 - transparency)

func set_panel_size(x: int, y: int):
	if $Panel.size.x != x or $Panel.size.y != y:
		$Panel.size.x = x
		$Panel.size.y = y

func set_panel_pos(px: int, py: int):
	if $Panel.position.x != x or $Panel.position.y != y:
		$Panel.position.x = x
		$Panel.position.y = y

func set_panel_transparency(t: float):
	if $Panel.self_modulate.a != t:
		$Panel.self_modulate.a = clampf(t, 0.0, 1.0)


func advance_text():
	var spd = text_speed
	if Input.is_action_just_pressed(speedup_button) or sped_up:
		spd = text_speed * text_speedup_ratio
		sped_up = true
	if $Panel/Text.visible_ratio < 1.0:
		$Panel/Text.visible_ratio = clampf($Panel/Text.visible_ratio + spd, 0.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_text()
	set_panel()
	advance_text()
	#TODO: play a sound every x frames.
