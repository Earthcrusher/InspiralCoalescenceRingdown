/datum/context/password_entry/OnNonCommandTextEntry(var/mob/viewer, var/list/tokens)
	if(tokens && tokens.len >= 1)
		if(players.ComparePasswords(viewer, Encode(tokens[1])))
			to_chat(viewer, "Password correct.")
			viewer.SetContext(/datum/context/world)
			return
	to_chat(viewer, "Invalid password.")
	viewer.SetContext(/datum/context/login)

/datum/context/password_entry/OnContextSet(var/mob/viewer)
	to_chat(viewer, "Please enter your password.")
