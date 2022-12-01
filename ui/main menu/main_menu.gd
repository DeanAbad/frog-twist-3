extends Control

enum MenuState { NONE, OPTIONS, CREDITS, HELP }
var state : int = MenuState.NONE
func changeState(ns : int) -> void:
	if ns == state:
		return

func _ready() -> void:
	grab_focus()

func _play() -> void:
	$transition.visible = true
	$transition/animator.play("fade_out")
func _start_game(_x) -> void:
	get_tree().change_scene_to(Globals.gameScene)

func _options() -> void:
	get_tree().change_scene("res://ui/main menu/Options.tscn")

func _credits() -> void:
	get_tree().change_scene("res://ui/main menu/Credits.tscn")

func _help() -> void:
	get_tree().change_scene("res://ui/main menu/Help.tscn")

func _quit() -> void:
	get_tree().quit()

## Handle sunflower animations for focused buttons, also keep track of which button is currently focused
enum BoardButton { NONE = -1, PLAY, OPTIONS, CREDITS, HELP, QUIT }
var currentlyFocused : int = BoardButton.NONE
func _board_button_focus(index : int) -> void:
	displaySunflowersAtButton(index)
func _board_button_unfocus(index : int) -> void:
	if currentlyFocused != index:
		return
	displaySunflowersAtButton(BoardButton.NONE)
# index -1 turns off all sunflowers
func displaySunflowersAtButton(index : int) -> void:
	currentlyFocused = index
	$BaseSprites/SunflowersPlay.visible = false
	$BaseSprites/SunflowersOptions.visible = false
	$BaseSprites/SunflowersCredits.visible = false
	$BaseSprites/SunflowersHelp.visible = false
	$BaseSprites/SunflowersQuit.visible = false
	match index:
		BoardButton.NONE: return
		BoardButton.PLAY: $BaseSprites/SunflowersPlay.visible = true
		BoardButton.OPTIONS: $BaseSprites/SunflowersOptions.visible = true
		BoardButton.CREDITS: $BaseSprites/SunflowersCredits.visible = true
		BoardButton.HELP: $BaseSprites/SunflowersHelp.visible = true
		BoardButton.QUIT: $BaseSprites/SunflowersQuit.visible = true
