/datum/room
	var/id
	var/short
	var/long
	var/list/exits
	var/list/neighbors
	var/list/contents

/datum/room/New()
	..()
	neighbors = list()
	contents = list()

/datum/room/proc/AddPlayer(var/mob/player, var/datum/room/coming_from)
	var/arrival = "nowhere"
	if(coming_from)
		arrival = "\the [neighbors[coming_from.id]]"
	ShowContents("\The [player.name] arrives from [arrival].")
	contents[player] = TRUE
	player.SetRoom(src)

/datum/room/proc/ShowContents(var/msg)
	for(var/thing in contents)
		var/mob/C = thing
		to_chat(C, msg)

/datum/room/proc/RemovePlayer(var/mob/player, var/datum/room/leaving_for)
	var/departing = "nowhere"
	if(leaving_for)
		departing = "\the [leaving_for.neighbors[id]]"
	contents -= player
	ShowContents("\The [player.name] leaves to [departing].")
	player.SetRoom()

/datum/room/proc/ValidateExits()
	neighbors.Cut()
	for(var/exit in exits)
		if(!rooms.GetRoom(exits[exit]))
			exits -= exit
		else
			neighbors[exits[exit]] = exit

/datum/room/proc/ShowTo(var/mob/viewer)
	to_chat(viewer, "<font color = '#00ffff'><b>[short]</b></font>")
	to_chat(viewer, "<font color = '#ffffff'>[long]</font>")
	if((!contents[viewer] && contents.len) || contents.len > 1)
		var/contents_summary = "<font color = '#ffffff'><b>"
		for(var/thing in contents)
			if(thing != viewer)
				contents_summary += "\The [thing] is here."
		contents_summary += "</b></font>"
		to_chat(viewer, contents_summary)
	to_chat(viewer, "<font color = '#00ffff'>You see exits leading: <b>[EnglishList(exits)]</b></font>")
