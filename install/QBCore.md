1. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

2. Ensure the resource in server.cfg

3. Copy and paste images into qb-inventory/html/images

4. Add these items in qb-core/shared/items.lua

['tuna'] 			 		 	 = {['name'] = 'tuna', 							['label'] = 'Tuna', 				    ['weight'] = 10000, 		['type'] = 'item', 		['image'] = 'tuna.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['titanium_rod'] 			 		 	 = {['name'] = 'titanium_rod', 							['label'] = 'Titanium rod', 				    ['weight'] = 450, 		['type'] = 'item', 		['image'] = 'titanium_rod.png', 		        ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['basic_rod'] 			 		 	 = {['name'] = 'basic_rod', 							['label'] = 'Fishing rod', 				    ['weight'] = 250, 		['type'] = 'item', 		['image'] = 'basic_rod.png', 		        ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['anchovy'] 			 		 	 = {['name'] = 'anchovy', 							['label'] = 'Anchovy', 				    ['weight'] = 20, 		['type'] = 'item', 		['image'] = 'anchovy.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['shark'] 			 		 	 = {['name'] = 'shark', 							['label'] = 'Shark', 				    ['weight'] = 7500, 		['type'] = 'item', 		['image'] = 'shark.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['mahi_mahi'] 			 		 	 = {['name'] = 'mahi_mahi', 							['label'] = 'Mahi Mahi', 				    ['weight'] = 3500, 		['type'] = 'item', 		['image'] = 'mahi_mahi.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['trout'] 			 		 	 = {['name'] = 'trout', 							['label'] = 'Trout', 				    ['weight'] = 750, 		['type'] = 'item', 		['image'] = 'trout.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['salmon'] 			 		 	 = {['name'] = 'salmon', 							['label'] = 'Salmon', 				    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'salmon.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['red_snapper'] 			 		 	 = {['name'] = 'red_snapper', 							['label'] = 'Red Snapper', 				    ['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'red_snapper.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['piranha'] 			 		 	 = {['name'] = 'piranha', 							['label'] = 'Piranha', 				    ['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'piranha.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['graphite_rod'] 			 		 	 = {['name'] = 'graphite_rod', 							['label'] = 'Graphite rod', 				    ['weight'] = 350, 		['type'] = 'item', 		['image'] = 'graphite_rod.png', 		        ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['worms'] 			 		 	 = {['name'] = 'worms', 							['label'] = 'Worms', 				    ['weight'] = 10, 		['type'] = 'item', 		['image'] = 'worms.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['haddock'] 			 		 	 = {['name'] = 'haddock', 							['label'] = 'Haddock', 				    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'haddock.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['grouper'] 			 		 	 = {['name'] = 'grouper', 							['label'] = 'Grouper', 				    ['weight'] = 3500, 		['type'] = 'item', 		['image'] = 'grouper.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },
['artificial_bait'] 			 		 	 = {['name'] = 'artificial_bait', 							['label'] = 'Artificial bait', 				    ['weight'] = 30, 		['type'] = 'item', 		['image'] = 'artificial_bait.png', 		        ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = '' },

5. Import import.sql to your database.
