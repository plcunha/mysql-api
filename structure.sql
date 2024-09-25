DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1,	'Notícias',	'2024-09-24 16:20:05'),
(2,	'Eventos',	'2024-09-24 16:20:05'),
(3,	'Acadêmico',	'2024-09-24 16:20:05');

DROP TABLE IF EXISTS `login_logs`;
CREATE TABLE `login_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `status` enum('success','failure') NOT NULL,
  `attempted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `login_logs` (`id`, `email`, `status`, `attempted_at`) VALUES
(1,	'j@gmail.com',	'success',	'2024-09-24 16:51:49'),
(2,	'j@idnnd.com',	'failure',	'2024-09-24 16:52:27'),
(3,	'a@gmail.com',	'success',	'2024-09-25 16:28:50'),
(4,	'a@gmail.com',	'success',	'2024-09-25 16:32:39'),
(5,	'a@gmail.com',	'success',	'2024-09-25 16:36:18'),
(6,	'a@gmail.com',	'success',	'2024-09-25 16:41:21'),
(7,	'b@gmail.com',	'success',	'2024-09-25 17:01:55');

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `user_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `posts_ibfk_1` (`user_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','author','reader') NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `active`, `created_at`) VALUES
(7,	'a',	'a@gmail.com',	'123',	'admin',	1,	'2024-09-25 16:47:04'),
(8,	'b',	'b@gmail.com',	'123',	'admin',	1,	'2024-09-25 17:01:45');