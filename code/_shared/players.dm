var/datum/player_repository/players = new()

/datum/player_repository
	var/list/players

/datum/player_repository/New()
	..()
	players = list()

/datum/player_repository/proc/PlayerLoggedIn(var/mob/_player, var/_name)
	players[_name] = TRUE
	_player.name = _name
	world.log << "Player logged in: [_name]."

/datum/player_repository/proc/PlayerLoggedOut(var/mob/_player, var/_name)
	players -= _name
	world.log << "Player logged out: [_name]."

/datum/player_repository/proc/CheckNameAvailability(var/_name)
	return (players[_name] == null)

/datum/player_repository/proc/GetProfile(var/playername)
	return

/datum/player_repository/proc/ComparePasswords(var/mob/_player, var/check_hash)
	var/datum/player_profile/player = GetProfile(_player.name)
	return (player && check_hash == player.password_hash)

/datum/player_profile
	var/username
	var/password_hash
	var/email
