CREATE TABLE IF NOT EXISTS `daily_kits_standalone` (
    `identifier` VARCHAR(60) NOT NULL,
    `last_claim` INT(11) NOT NULL,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;