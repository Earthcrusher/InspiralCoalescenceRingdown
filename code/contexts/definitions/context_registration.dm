#define PLAYER_STATE_ENTER_NAME       1
#define PLAYER_STATE_ENTER_PASSWORD   2
#define PLAYER_STATE_CONFIRM_PASSWORD 3

/datum/context/registration
	var/list/password_cache
	var/list/username_cache

/datum/context/registration/New()
	..()
	password_cache = list()
	username_cache = list()

/datum/context/registration/OnContextUnset(var/mob/viewer)
	. = ..()
	password_cache -= viewer
	username_cache -= viewer

/datum/context/registration/OnContextSet(var/mob/viewer)
	to_chat(viewer, "Please enter a new username.")
	player_state_data[viewer] = PLAYER_STATE_ENTER_NAME

/datum/context/registration/OnNonCommandTextEntry(var/mob/viewer, var/list/tokens)

	var/token = (tokens && tokens.len >= 1) ? lowertext(trim(tokens[1])) : null

	if(token == "" || !token)

		switch(player_state_data[viewer])
			if(PLAYER_STATE_ENTER_NAME)
				to_chat(viewer, "Please enter the name you wish to use, or enter cancel to exit.")
			if(PLAYER_STATE_ENTER_PASSWORD)
				to_chat(viewer, "Please enter a new password, or enter cancel to exit.")
			if(PLAYER_STATE_CONFIRM_PASSWORD)
				to_chat(viewer, "Please confirm your previously entered password, or enter cancel to exit.")

	else if(token == "cancel")

		viewer.SetContext(/datum/context/login)

	else

		switch(player_state_data[viewer])
			if(PLAYER_STATE_ENTER_NAME)
				token = capitalize(token)
				if(!players.CheckNameAvailability(token))
					to_chat(viewer, "The name [token] is currently unavailable. Please try again.")
				else
					username_cache[viewer] = token
					player_state_data[viewer] = PLAYER_STATE_ENTER_PASSWORD
					to_chat(viewer, "Please enter a new password.")

			if(PLAYER_STATE_ENTER_PASSWORD)
				password_cache[viewer] = token
				player_state_data[viewer] = PLAYER_STATE_CONFIRM_PASSWORD
				to_chat(viewer, "Please repeat your password to confirm.")

			if(PLAYER_STATE_CONFIRM_PASSWORD)
				if(password_cache[viewer] == token)
					players.PlayerLoggedIn(viewer, username_cache[viewer])
					to_chat(viewer, "You have registered as [viewer.name]. Welcome to the game!")
					viewer.SetContext(/datum/context/world)
				else
					to_chat(viewer, "Please confirm your previously entered password, or enter cancel to exit.")

#undef PLAYER_STATE_ENTER_NAME
#undef PLAYER_STATE_ENTER_PASSWORD
#undef PLAYER_STATE_CONFIRM_PASSWORD
