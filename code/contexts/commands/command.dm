/datum/command
	var/name = "command"
	var/list/aliases

/datum/command/proc/Invoked(var/mob/_invoker, var/list/_tokens)
	to_chat(_invoker, "You sent the command '[jointext(_tokens, " ")]'.")
