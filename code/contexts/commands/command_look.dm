/datum/command/look
	name = "look"
	aliases = list("l", "ql")

/datum/command/look/Invoked(var/mob/_invoker, var/list/_tokens)
	if(_invoker.room)
		if(_tokens && _tokens.len >= 2)
			var/lookdir = lowertext(trim(_tokens[2]))
			if(lookdir && lookdir != "")
				var/datum/room/looking = rooms.GetRoom(_invoker.room.exits[lookdir])
				if(looking)
					to_chat(_invoker, "You glance away to \the [lookdir]:")
					looking.ShowTo(_invoker)
				else
					to_chat(_invoker, "You cannot see anything in that direction.")
		else
			_invoker.ShowLocalArea()
	else
		to_chat(_invoker, "You can see nothing.")
