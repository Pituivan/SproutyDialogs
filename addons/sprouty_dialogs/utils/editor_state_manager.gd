@tool
class_name SproutyDialogsEditorStateManager
extends RefCounted

# -----------------------------------------------------------------------------
# Sprouty Dialogs State Editor Manager
# -----------------------------------------------------------------------------
## This class manages the temporary editor parameters for the Sprouty Dialogs plugin.
## It provides methods to get and set editor default values.
# -----------------------------------------------------------------------------

## Temporary editor state parameters.
## This cache file stores settings which should not be versioned.
static var _editor_state_file: ConfigFile:
	get:
		if _editor_state_file:
			return _editor_state_file

		var file := ConfigFile.new()
		const PATH := "res://.godot/sprouty_dialogs.conf"

		if FileAccess.file_exists(PATH):
			var load_result := file.load(PATH)
			if load_result == OK:
				_editor_state_file = file
				return file
			else:
				printerr("[SproutyDialogs] Couldn't load editor state cache file. An error occurred: "
					+ error_string(load_result))
				return null

		# Set default values
		file.set_value("window_state", "play_dialog_path", "")
		file.set_value("window_state", "play_start_id", "")
		file.set_value("window_state", "last_opened_files", [])
		file.set_value("window_state", "last_selected_file_index", -1)

		file.save(PATH)
		_editor_state_file = file
		return file


## Returns an editor state value from the cache file.
## If the value section or key are not found, it returns null and prints an error message.
static func get_value(section: String, key: String) -> Variant:
	if not _editor_state_file.has_section(section):
		printerr("[SproutyDialogs] Editor state section '" + section + "' not found.")
		return null
	if not _editor_state_file.has_section_key(section, key):
		printerr("[SproutyDialogs] Editor state key '" + key + "' not found in section '" + section + "'.")
		return null

	return _editor_state_file.get_value(section, key)


## Sets an editor state value in the cache file.
## If the value section or key are not found, it prints an error message.
static func set_value(section: String, key: String, value: Variant) -> void:
	if not _editor_state_file.has_section(section):
		printerr("[SproutyDialogs] Editor state section '" + section + "' not found."
			+ "Cannot set value of key '" + key + "' for that section.")
		return
	if not _editor_state_file.has_section_key(section, key):
		printerr("[SproutyDialogs] Editor state key '" + key + "' not found in section '" + section
			+ "'. Cannot set value.")
		return

	_editor_state_file.set_value(section, key, value)
	_editor_state_file.save("res://.godot/sprouty_dialogs.conf")
