1. Install these dependecies:
    ox_lib - https://github.com/overextended/ox_lib/releases/latest/download/ox_lib.zip
    ox_target/qtarget/qb-target (Optional, depends on config)

2. Ensure the resource in server.cfg

3. Copy and paste images into qb-inventory/html/images

4. Add these items in qb-core/shared/items.lua

['contract'] 			 		 	 = {['name'] = 'contract', 							['label'] = 'Contract', 				    ['weight'] = 100, 		['type'] = 'item', 		['image'] = 'contract.png', 		        ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Used for selling/transfering vehicles.'},

5. Import this in your database:
    ALTER TABLE `player_vehicles`
    ADD COLUMN `job` VARCHAR(20) NULL DEFAULT NULL;

    ALTER TABLE `player_vehicles`
    ADD COLUMN `type` VARCHAR(20) NOT NULL DEFAULT 'car';

    ALTER TABLE `player_vehicles`
    ADD COLUMN `stored` TINYINT(1) NOT NULL DEFAULT '0';

6. Delete old player_vehicles in database and import this incase of having problems:
    CREATE TABLE IF NOT EXISTS `player_vehicles` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `license` varchar(50) DEFAULT NULL,
        `citizenid` varchar(50) DEFAULT NULL,
        `vehicle` varchar(50) DEFAULT NULL,
        `hash` varchar(50) DEFAULT NULL,
        `mods` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
        `plate` varchar(15) NOT NULL,
        `fakeplate` varchar(50) DEFAULT NULL,
        `garage` varchar(50) DEFAULT 'pillboxgarage',
        `fuel` int(11) DEFAULT 100,
        `engine` float DEFAULT 1000,
        `body` float DEFAULT 1000,
        `state` int(11) DEFAULT 1,
        `depotprice` int(11) NOT NULL DEFAULT 0,
        `drivingdistance` int(50) DEFAULT NULL,
        `status` text DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `plate` (`plate`),
        KEY `citizenid` (`citizenid`),
        KEY `license` (`license`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1;

    ALTER TABLE `player_vehicles`
    ADD UNIQUE INDEX UK_playervehicles_plate (plate);

    ALTER TABLE `player_vehicles`
    ADD CONSTRAINT FK_playervehicles_players FOREIGN KEY (citizenid)
    REFERENCES `players` (citizenid) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `player_vehicles`
    ADD COLUMN `balance` int(11) NOT NULL DEFAULT 0;
    ALTER TABLE `player_vehicles`
    ADD COLUMN `paymentamount` int(11) NOT NULL DEFAULT 0;
    ALTER TABLE `player_vehicles`
    ADD COLUMN `paymentsleft` int(11) NOT NULL DEFAULT 0;
    ALTER TABLE `player_vehicles`
    ADD COLUMN `financetime` int(11) NOT NULL DEFAULT 0;
    
    ALTER TABLE `player_vehicles`
    ADD COLUMN `job` VARCHAR(20) NULL DEFAULT NULL;

    ALTER TABLE `player_vehicles`
    ADD COLUMN `type` VARCHAR(20) NOT NULL DEFAULT 'car';

    ALTER TABLE `player_vehicles`
    ADD COLUMN `stored` TINYINT(1) NOT NULL DEFAULT '0';