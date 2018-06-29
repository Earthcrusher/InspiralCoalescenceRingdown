/datum/command/emote
	name = "emote"
	aliases = list("me", "em")

/datum/command/emote/Invoked(var/mob/_invoker, var/list/_tokens)
	if(_tokens && _tokens.len > 1)
		var/message_body = FormatForDisplay(jointext(_tokens - _tokens[1], " "))
		if(message_body && message_body != "")
			var/list/components = BreakStringIntoPerformedComponents(message_body)
			var/first_part = capitalize(components[1])
			var/second_part = components[2]
			if(second_part && second_part != "")
				if(first_part && first_part != "")
					_invoker.room.ShowContents("<font color = '#ffffff'>[first_part] <b>[_invoker.name]</b> [second_part]</font>")
				else
					_invoker.room.ShowContents("<font color = '#ffffff'><b>[_invoker.name]</b> [second_part]</font>")
				return
	to_chat(_invoker, "Please enter an emote to perform.</span>")
