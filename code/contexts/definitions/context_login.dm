/datum/context/login
	commands = list(/datum/command/register)

/datum/context/login/OnContextSet(var/mob/viewer)
	to_chat(viewer, "<font color = '#ff0000'>    ========= <b>Welcome</b> to <i>Inspiral, Coalescence, Ringdown</i> =========</font>")
	to_chat(viewer, "")
	to_chat(viewer, "<font color = '#ffffff'>         - Enter your username to log in.</font>")
	to_chat(viewer, "<font color = '#ffffff'>         - Enter <b>register</b> to register a new account.</font>")
	to_chat(viewer, "")
	to_chat(viewer, "<font color = '#ff0000'>    ==============================================================</font>")


/datum/context/login/OnNonCommandTextEntry(var/mob/viewer, var/list/tokens)
	var/token = (tokens && tokens.len >= 1) ? lowertext(trim(tokens[1])) : null
	if(token)
		var/datum/player_profile/player = players.GetProfile(token)
		if(player)
			viewer.name = token
			viewer.SetContext(/datum/context/password_entry)
		else
			to_chat(viewer, "No character exists by the name 'token'.")
