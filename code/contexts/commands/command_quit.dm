/datum/command/quit
	name = "quit"
	aliases = list("qq")

/datum/command/quit/Invoked(var/mob/_invoker, var/list/_tokens)
	to_chat(_invoker, "Goodbye!")
	del(_invoker.client)
	del(_invoker)
