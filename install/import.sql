CREATE TABLE IF NOT EXISTS `lunar_fishing` (
  `user_identifier` varchar(50) NOT NULL,
  `xp` float NOT NULL,
  PRIMARY KEY (`user_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `lunar_fishing` (`user_identifier`, `xp`) VALUES
	('char1:688f639c6352c2b78a5bc72e076b819c9203cf2d', 3.05),
	('char1:fc18d29adec22f390169ccfe58de84232759ddc4', 3.35);