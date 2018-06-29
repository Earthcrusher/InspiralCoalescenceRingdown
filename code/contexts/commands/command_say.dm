/datum/command/say
	name = "say"
	aliases = list("'", "s")

/datum/command/say/Invoked(var/mob/_invoker, var/list/_tokens)
	if(_tokens && _tokens.len > 1)
		var/message_body = FormatForDisplay(jointext(_tokens - _tokens[1], " "))
		if(message_body && message_body != "")

			var/speech_verb = "says"
			var/ending = copytext(message_body, length(message_body))
			if(ending == "!")
				speech_verb = "exclaims"
			else if(ending == "?")
				speech_verb = "asks"

			var/list/components = BreakStringIntoPerformedComponents(message_body)
			var/first_part = components[1]
			var/second_part = capitalize(components[2])
			if(second_part && second_part != "")
				if(first_part && first_part != "")
					_invoker.room.ShowContents("<font color = '#ffffff'>[first_part], <b>[_invoker.name]</b> [speech_verb], \"<b>[second_part]</b>\"</font>")
				else
					_invoker.room.ShowContents("<font color = '#ffffff'><b>[_invoker.name]</b> [speech_verb], \"<b>[second_part]</b>\"</font>")
				return

	to_chat(_invoker, "You open your mouth, but say nothing.</span>")
