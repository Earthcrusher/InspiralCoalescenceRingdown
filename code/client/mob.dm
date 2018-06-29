/mob
	var/list/contexts
	var/datum/room/room

/mob/New()
	..()
	contexts = list()

/mob/proc/ShowLocalArea()
	if(room) room.ShowTo(src)

/mob/proc/SetRoom(var/datum/room/_room)
	room = _room

/mob/proc/AddContext(var/_context)
	if(contexts[_context])
		return
	var/datum/context/context = singletons.GetSingleton(_context)
	context.OnContextSet(src)
	contexts[_context] = context

/mob/proc/SetContext(var/_context)
	for(var/thing in contexts)
		if(thing == _context) continue
		var/datum/context/context = contexts[thing]
		context.OnContextUnset(src)
	contexts.Cut()
	AddContext(_context)
