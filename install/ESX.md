1. Use OX.md if you're using ox_inventory, otherwise follow this tutorial.

2. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

3. Ensure the resource in server.cfg

5. Copy and paste images into esx_inventoryhud/html/images (Or your inventory images folder)

6. Import this in your database:

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('graphite_rod', 'Graphite rod', 350),
    ('grouper', 'Grouper', 3500),
    ('mahi_mahi', 'Mahi Mahi', 3500),
    ('basic_rod', 'Fishing rod', 250),
    ('haddock', 'Haddock', 500),
    ('artificial_bait', 'Artificial bait', 30),
    ('trout', 'Trout', 750),
    ('red_snapper', 'Red Snapper', 2500),
    ('shark', 'Shark', 7500),
    ('anchovy', 'Anchovy', 20),
    ('salmon', 'Salmon', 1000),
    ('tuna', 'Tuna', 10000),
    ('piranha', 'Piranha', 1500),
    ('worms', 'Worms', 10),
    ('titanium_rod', 'Titanium rod', 450)
;

5. Import import.sql to your database.