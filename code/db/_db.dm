var/database/db

/proc/InitializeEntityDatabase()

	// Init/load DB
	db = new("data/game_entities.db")

	// Init schema if needed
	var/database/query/query = new(
		"CREATE TABLE IF NOT EXISTS objects ( \
		ident TEXT PRIMARY KEY NOT NULL UNIQUE, \
		name TEXT NOT NULL DEFAULT 'a generic object' \
		short_desc TEXT NOT NULL DEFAULT 'a generic object' \
		long_desc TEXT NOT NULL DEFAULT 'This is a generic object. Looking at it makes your eyes hurt.' \
		);")
	query.Execute(db)