/datum/context
	var/list/commands
	var/list/player_state_data

/datum/context/New()
	..()
	player_state_data = list()

/datum/context/Initialize()
	if(commands)
		var/list/commands_to_init = commands.Copy()
		commands = list()
		for(var/_cmd in commands_to_init)
			var/datum/command/command = singletons.GetSingleton(_cmd)
			commands[command.name] = command
			if(command.aliases)
				for(var/alias in command.aliases)
					commands[alias] = command
	. = ..()

/datum/context/proc/OnContextSet(var/mob/viewer)
	return

/datum/context/proc/OnContextUnset(var/mob/viewer)
	player_state_data -= viewer

/datum/context/proc/OnCommandEntry(var/mob/viewer, var/command_string)
	var/list/tokens = splittext(command_string, " ")
	if(tokens && tokens.len)
		var/cmd_token = lowertext(tokens[1])
		if(commands && commands[cmd_token])
			var/datum/command/command = commands[cmd_token]
			command.Invoked(viewer, tokens)
			return TRUE
	OnNonCommandTextEntry(viewer, tokens)
	return TRUE

/datum/context/proc/OnNonCommandTextEntry(var/mob/viewer, var/list/tokens)
	if(!tokens || !tokens.len)
		return
	to_chat(viewer, "Invalid command '[jointext(tokens, " ")]'.")
