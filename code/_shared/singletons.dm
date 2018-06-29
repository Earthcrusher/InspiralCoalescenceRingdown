var/datum/singleton_repository/singletons = new()

/datum/singleton_repository
	var/list/singletons

/datum/singleton_repository/New()
	..()
	singletons = list()

/datum/singleton_repository/proc/GetSingleton(var/_singleton)
	if(!singletons[_singleton])
		var/datum/sing = new _singleton
		singletons[_singleton] = sing
	return singletons[_singleton]
