1. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

2. Ensure the resource in server.cfg

3. Copy and paste images into ox_inventory/web/build/images

4. Add this to ox_inventory/data/items.lua:

	['basic_rod'] = {
		label = 'Fishing rod',
		stack = false,
		weight = 250
	},

	['graphite_rod'] = {
		label = 'Graphite rod',
		stack = false,
		weight = 350
	},

	['titanium_rod'] = {
		label = 'Titanium rod',
		stack = false,
		weight = 450
	},

	['worms'] = {
		label = 'Worms',
		weight = 10
	},

	['artificial_bait'] = {
		label = 'Artificial bait',
		weight = 30
	},

	['anchovy'] = {
		label = 'Anchovy',
		weight = 20
	},

	['grouper'] = {
		label = 'Grouper',
		weight = 3500
	},

	['haddock'] = {
		label = 'Haddock',
		weight = 500
	},

	['mahi_mahi'] = {
		label = 'Mahi Mahi',
		weight = 3500
	},

	['piranha'] = {
		label = 'Piranha',
		weight = 1500
	},

	['red_snapper'] = {
		label = 'Red Snapper',
		weight = 2500
	},

	['salmon'] = {
		label = 'Salmon',
		weight = 1000
	},

	['shark'] = {
		label = 'Shark',
		weight = 7500
	},

	['trout'] = {
		label = 'Trout',
		weight = 750
	},

	['tuna'] = {
		label = 'Tuna',
		weight = 10000
	},

5. Import import.sql to your database.