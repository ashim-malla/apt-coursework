CREATE DATABASE IF NOT EXISTS bike_rental;
USE bike_rental;

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `account_status` enum('active','suspended','banned') DEFAULT 'active',
  `role` enum('customer','staff','admin') DEFAULT 'customer',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `user` 
(`user_id`, `name`, `email`, `password`, `phone`, `license_number`, `account_status`, `role`) 
VALUES 
(6, 'AshimMalla', 'ashimmalla00@gmail.com', '$2a$10$XQr.MVvLSUDhfpMRjKKqAeAynvY1T2YselnBaeg/tfQiXzmYJ46q6', '9804145102', '0527ashim', 'active', 'admin')
ON DUPLICATE KEY UPDATE name = VALUES(name);
