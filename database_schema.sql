-- Database Schema for E-Book Java Application (MySQL / TiDB Compatible)

-- 1. Create `user` table
CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `phone` VARCHAR(20) DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) DEFAULT NULL,
  `landmark` VARCHAR(100) DEFAULT NULL,
  `city` VARCHAR(100) DEFAULT NULL,
  `state` VARCHAR(100) DEFAULT NULL,
  `pincode` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Create `book_dtls` table
CREATE TABLE IF NOT EXISTS `book_dtls` (
  `bookId` INT NOT NULL AUTO_INCREMENT,
  `bookname` VARCHAR(255) DEFAULT NULL,
  `author` VARCHAR(255) DEFAULT NULL,
  `price` VARCHAR(50) DEFAULT NULL,
  `bookCategory` VARCHAR(100) DEFAULT NULL,
  `status` VARCHAR(50) DEFAULT NULL,
  `photo` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(150) DEFAULT NULL,
  PRIMARY KEY (`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Create `cart` table
CREATE TABLE IF NOT EXISTS `cart` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `bid` INT DEFAULT NULL,
  `uid` INT DEFAULT NULL,
  `bookName` VARCHAR(255) DEFAULT NULL,
  `author` VARCHAR(255) DEFAULT NULL,
  `price` DOUBLE DEFAULT NULL,
  `total_price` DOUBLE DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Create `book_order` table
CREATE TABLE IF NOT EXISTS `book_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orderNo` VARCHAR(100) DEFAULT NULL,
  `bookName` VARCHAR(255) DEFAULT NULL,
  `author` VARCHAR(255) DEFAULT NULL,
  `price` VARCHAR(50) DEFAULT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  `email` VARCHAR(150) DEFAULT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `address` VARCHAR(255) DEFAULT NULL,
  `landmark` VARCHAR(100) DEFAULT NULL,
  `city` VARCHAR(100) DEFAULT NULL,
  `state` VARCHAR(100) DEFAULT NULL,
  `pincode` VARCHAR(20) DEFAULT NULL,
  `paymentType` VARCHAR(50) DEFAULT NULL,
  `order_status` VARCHAR(50) DEFAULT 'Pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ==========================================
-- Sample Data Insertion
-- ==========================================

-- Insert Sample Users
INSERT INTO `user` (`name`, `email`, `phone`, `password`, `address`, `landmark`, `city`, `state`, `pincode`) VALUES 
('Alice Smith', 'alice@gmail.com', '1234567890', 'password123', '123 Main St', 'Near Park', 'New York', 'NY', '10001'),
('Bob Johnson', 'bob@gmail.com', '0987654321', 'password123', '456 Oak St', 'Downtown', 'San Francisco', 'CA', '94101');

-- Insert Sample Books
INSERT INTO `book_dtls` (`bookname`, `author`, `price`, `bookCategory`, `status`, `photo`, `email`) VALUES 
('Clean Code', 'Robert C. Martin', '45.00', 'New', 'Active', 'cleancode.jpg', 'admin@gmail.com'),
('Effective Java', 'Joshua Bloch', '50.00', 'New', 'Active', 'effectivejava.jpg', 'admin@gmail.com'),
('Head First Design Patterns', 'Eric Freeman', '40.00', 'Old', 'Active', 'designpatterns.jpg', 'alice@gmail.com');

-- Insert Sample Cart Items (Assuming Alice - uid 1 added Clean Code - bid 1)
INSERT INTO `cart` (`bid`, `uid`, `bookName`, `author`, `price`, `total_price`) VALUES 
(1, 1, 'Clean Code', 'Robert C. Martin', 45.00, 45.00);

-- Insert Sample Order
INSERT INTO `book_order` (`orderNo`, `bookName`, `author`, `price`, `name`, `email`, `phone`, `address`, `landmark`, `city`, `state`, `pincode`, `paymentType`, `order_status`) VALUES 
('ORD-102938', 'Effective Java', 'Joshua Bloch', '50.00', 'Alice Smith', 'alice@gmail.com', '1234567890', '123 Main St', 'Near Park', 'New York', 'NY', '10001', 'Credit Card', 'Pending');
