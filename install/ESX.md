1. Use OX.md if you're using ox_inventory, otherwise follow this tutorial.

2. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

3. Ensure the resource in server.cfg

5. Copy and paste images into esx_inventoryhud/html/images (Or your inventory images folder)

6. Import this in your database:

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('contract', 'Contract', 100)
;

4. Delete old owned_vehicles in database and import this incase of having problems:
    CREATE TABLE `owned_vehicles` (
        `owner` VARCHAR(60) NOT NULL,
        `plate` varchar(12) NOT NULL,
        `vehicle` longtext,
        `type` VARCHAR(20) NOT NULL DEFAULT 'car',
        `job` VARCHAR(20) NULL DEFAULT NULL,
        `stored` TINYINT(1) NOT NULL DEFAULT '0',

        PRIMARY KEY (`plate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;a