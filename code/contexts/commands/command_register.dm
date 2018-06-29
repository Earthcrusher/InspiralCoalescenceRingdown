/datum/command/register
	name = "register"

/datum/command/register/Invoked(var/mob/_invoker, var/list/_tokens)
	_invoker.SetContext(/datum/context/registration)
