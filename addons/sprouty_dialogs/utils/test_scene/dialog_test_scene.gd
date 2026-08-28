extends Control

# -----------------------------------------------------------------------------
# Test scene for playing a dialog
# -----------------------------------------------------------------------------
## This scene is used to test the dialog system in isolation.
## It loads a dialog and starts playing it automatically.
# -----------------------------------------------------------------------------

func _ready() -> void:
	var autoload = get_node("/root/SproutyDialogs")
	var dialog_path = SproutyDialogsEditorStateManager.get_value("window_state", "play_dialog_path")
	var start_id = SproutyDialogsEditorStateManager.get_value("window_state", "play_start_id")

	print("[Sprouty Dialogs] Playing dialog test scene...")
	autoload.start_dialog(load(dialog_path), start_id)
	autoload.dialog_ended.connect(get_tree().quit) # Quit when done
