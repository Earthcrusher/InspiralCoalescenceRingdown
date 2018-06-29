/client/New()
	..()
	if(mob.name)
		players.PlayerLoggedIn(mob, mob.name)
	if(!mob.contexts || !mob.contexts.len)
		mob.SetContext(/datum/context/login)
	if(mob.room)
		mob.room.ShowTo(mob)

/client/Del()
	if(mob && mob.name)
		players.PlayerLoggedOut(mob, mob.name)
	. = ..()

/client/Command(command as command_text)
	if(mob && mob.contexts)
		for(var/thing in mob.contexts)
			var/datum/context/context = mob.contexts[thing]
			if(context.OnCommandEntry(mob, command))
				return
