var/datum/room_repository/rooms = new()

/datum/room_repository
	var/list/rooms_by_id

/datum/room_repository/New()
	rooms_by_id = list()
	..()

/datum/room_repository/Initialize()
	. = ..()
	AddRoom( \
		"spawn1", \
		"A featureless white room.", \
		"This is the spawning room. Why are you here?", \
		list(
			"north" = "spawn2",
			"dennis" = "spawn3",
			"south" = "thisisaroomthatdoesn'texist"
		), \
		FALSE
	)
	AddRoom( \
		"spawn2", \
		"Another featureless white room.", \
		"This is the room off the spawning room. Why are you here?", \
		list(
			"south" = "spawn1",
		), \
		FALSE
	)
	AddRoom( \
		"spawn3", \
		"Yet another featureless white room.", \
		"This is a third spawning room. Why are you here?", \
		list(
			"undennis" = "spawn1",
		), \
		FALSE
	)
	spawn(1)
		ValidateRooms()

/datum/room_repository/proc/PutInRoom(var/mob/player, var/new_room, var/exit)
	var/datum/room/newroom = GetRoom(new_room)
	if(newroom)
		if(player.room)
			newroom.AddPlayer(player, player.room)
			player.room.RemovePlayer(player, newroom)
		else
			newroom.AddPlayer(player)

/datum/room_repository/proc/GetRoom(var/_id)
	return rooms_by_id[_id]

/datum/room_repository/proc/ValidateRooms()
	for(var/roomid in rooms_by_id)
		var/datum/room/room = GetRoom(roomid)
		room.ValidateExits()

/datum/room_repository/proc/AddRoom(var/id, var/short, var/long, var/list/exits, var/validate_exits = TRUE)

	if(!GetRoom(id))
		rooms_by_id[id] = new /datum/room

	var/datum/room/modifying = GetRoom(id)
	modifying.id = id
	modifying.short = short
	modifying.long = long
	modifying.exits = exits

	if(validate_exits)
		modifying.ValidateExits()
