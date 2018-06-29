/datum/context/world
	commands = list(
		/datum/command/look,
		/datum/command/quit,
		/datum/command/say,
		/datum/command/emote
	)

/datum/context/world/OnContextSet(var/mob/viewer)
	rooms.PutInRoom(viewer, "spawn1")
	viewer.ShowLocalArea()

/datum/context/world/OnNonCommandTextEntry(var/mob/viewer, var/list/tokens)
	if(tokens && tokens.len >= 2 && viewer.room)
		var/try_exit = lowertext(trim(tokens[2]))
		var/try_room = viewer.room.exits[try_exit]
		if(rooms.GetRoom(try_room) && rooms.PutInRoom(viewer, try_room, try_exit))
			return
	. = ..()
