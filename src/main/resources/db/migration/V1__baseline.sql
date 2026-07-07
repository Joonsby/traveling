-- traveling.code_group definition

CREATE TABLE `code_group` (
  `group_code` varchar(50) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- traveling.facility definition

CREATE TABLE `facility` (
  `facility_code` varchar(50) NOT NULL,
  `facility_name` varchar(100) NOT NULL,
  `category` varchar(30) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `use_yn` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`facility_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- traveling.host_info definition

CREATE TABLE `host_info` (
  `host_id` varchar(20) NOT NULL,
  `pw` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `agency` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `business_num` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `birth` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `post_code` varchar(20) NOT NULL,
  `road_addr` varchar(50) NOT NULL,
  `jibun_addr` varchar(50) NOT NULL,
  `detail_addr` varchar(50) DEFAULT NULL,
  `reference_addr` varchar(50) NOT NULL,
  `join_date` datetime NOT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='호스트 회원가입';


-- traveling.reservation definition

CREATE TABLE `reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `room_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `check_in_time` time NOT NULL,
  `check_out_time` time NOT NULL,
  `people` int NOT NULL,
  `price` int NOT NULL,
  `payment_time` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `order_id` varchar(64) DEFAULT NULL COMMENT '토스 주문번호',
  `payment_key` varchar(200) DEFAULT NULL COMMENT '토스 결제 키',
  `payment_status` varchar(20) DEFAULT '결제대기' COMMENT '결제 상태',
  `paid_amount` int DEFAULT NULL COMMENT '실제 결제 금액',
  `payment_method` varchar(30) DEFAULT NULL COMMENT '결제 수단',
  `approved_at` datetime DEFAULT NULL COMMENT '승인 시각',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reservation_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `room_id_idx` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb3 COMMENT='예약 정보';


-- traveling.room_info definition

CREATE TABLE `room_info` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `stay_id` int NOT NULL,
  `room_name` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `price` int NOT NULL,
  `standard_people` int NOT NULL,
  `maximum_people` int NOT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `image4` varchar(255) DEFAULT NULL,
  `image5` varchar(255) DEFAULT NULL,
  `image6` varchar(255) DEFAULT NULL,
  `image7` varchar(255) DEFAULT NULL,
  `image8` varchar(255) DEFAULT NULL,
  `image9` varchar(255) DEFAULT NULL,
  `image10` varchar(255) DEFAULT NULL,
  `extra_person_fee` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;


-- traveling.user_info definition

CREATE TABLE `user_info` (
  `user_id` varchar(20) NOT NULL,
  `pw` varchar(20) NOT NULL,
  `name` varchar(5) NOT NULL,
  `agency` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `birth` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `post_code` varchar(20) NOT NULL,
  `road_addr` varchar(50) NOT NULL,
  `jibun_addr` varchar(50) NOT NULL,
  `detail_addr` varchar(50) DEFAULT NULL,
  `reference_addr` varchar(50) NOT NULL,
  `join_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='사용자 회원가입';


-- traveling.code definition

CREATE TABLE `code` (
  `code_id` varchar(50) NOT NULL,
  `group_code` varchar(50) NOT NULL,
  `code_name` varchar(100) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  PRIMARY KEY (`group_code`,`code_id`),
  CONSTRAINT `fk_code_group` FOREIGN KEY (`group_code`) REFERENCES `code_group` (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- traveling.mileage definition

CREATE TABLE `mileage` (
  `user_id` varchar(20) NOT NULL,
  `total_mileage` int NOT NULL DEFAULT '0',
  KEY `user_id` (`user_id`),
  CONSTRAINT `mileage_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='마일리지';


-- traveling.pending_reservation definition

CREATE TABLE `pending_reservation` (
  `pending_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `room_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `check_in_time` time NOT NULL,
  `check_out_time` time NOT NULL,
  `people` int NOT NULL,
  `amount` int NOT NULL,
  `payment_status` varchar(20) NOT NULL DEFAULT '결제대기',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pending_id`),
  UNIQUE KEY `pending_reservation_unique` (`order_id`),
  KEY `fk_pending_user` (`user_id`),
  KEY `fk_pending_room` (`room_id`),
  CONSTRAINT `fk_pending_room` FOREIGN KEY (`room_id`) REFERENCES `room_info` (`room_id`),
  CONSTRAINT `fk_pending_user` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;


-- traveling.planner definition

CREATE TABLE `planner` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`plan_id`),
  KEY `reservation_id_idx` (`reservation_id`),
  CONSTRAINT `planner_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='일정 플래너';


-- traveling.review_info definition

CREATE TABLE `review_info` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `review_title` varchar(45) NOT NULL,
  `review_content` text NOT NULL,
  `rating` varchar(45) NOT NULL,
  `review_time` varchar(45) NOT NULL,
  `image_path01` varchar(255) DEFAULT NULL,
  `image_path02` varchar(255) DEFAULT NULL,
  `image_path03` varchar(255) DEFAULT NULL,
  `image_path04` varchar(255) DEFAULT NULL,
  `image_path05` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  CONSTRAINT `fk_review_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb3;


-- traveling.stay_info definition

CREATE TABLE `stay_info` (
  `stay_id` int NOT NULL AUTO_INCREMENT,
  `host_id` varchar(20) NOT NULL,
  `stay_name` varchar(50) NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  `post_code` varchar(10) NOT NULL,
  `road_addr` varchar(50) NOT NULL,
  `jibun_addr` varchar(50) NOT NULL,
  `detail_addr` varchar(50) NOT NULL,
  `reference_addr` varchar(50) NOT NULL,
  `latitude` decimal(18,10) NOT NULL,
  `longitude` decimal(18,10) NOT NULL,
  `host_phone` varchar(20) NOT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `image4` varchar(255) DEFAULT NULL,
  `image5` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`stay_id`),
  KEY `host_id_idx` (`host_id`),
  CONSTRAINT `host_id` FOREIGN KEY (`host_id`) REFERENCES `host_info` (`host_id`),
  CONSTRAINT `stay_info_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `host_info` (`host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='숙소 정보';


-- traveling.wish_list definition

CREATE TABLE `wish_list` (
  `user_id` varchar(20) NOT NULL,
  `room_id` int NOT NULL,
  KEY `user_id_idx` (`user_id`),
  KEY `room_id_idx` (`room_id`),
  CONSTRAINT `room_id` FOREIGN KEY (`room_id`) REFERENCES `room_info` (`room_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='찜 목록';


-- traveling.detail_plan definition

CREATE TABLE `detail_plan` (
  `plan_id` int NOT NULL,
  `plan_date` date NOT NULL,
  `plan_start_time` time NOT NULL,
  `plan_end_time` time DEFAULT NULL,
  `plan_content` varchar(100) NOT NULL,
  KEY `fk_detail_plan_planner` (`plan_id`),
  CONSTRAINT `fk_detail_plan_planner` FOREIGN KEY (`plan_id`) REFERENCES `planner` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- traveling.favorite_plan definition

CREATE TABLE `favorite_plan` (
  `plan_id` int NOT NULL,
  `user_id` varchar(20) NOT NULL,
  KEY `fk_fav_planner` (`plan_id`),
  KEY `fk_fav_user_info` (`user_id`),
  CONSTRAINT `fk_fav_planner` FOREIGN KEY (`plan_id`) REFERENCES `planner` (`plan_id`),
  CONSTRAINT `fk_fav_user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- traveling.stay_facility definition

CREATE TABLE `stay_facility` (
  `stay_id` int NOT NULL,
  `facility_code` varchar(50) NOT NULL,
  PRIMARY KEY (`stay_id`,`facility_code`),
  KEY `fk_stay_facility_code` (`facility_code`),
  CONSTRAINT `fk_stay_facility_code` FOREIGN KEY (`facility_code`) REFERENCES `facility` (`facility_code`),
  CONSTRAINT `fk_stay_facility_stay` FOREIGN KEY (`stay_id`) REFERENCES `stay_info` (`stay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;