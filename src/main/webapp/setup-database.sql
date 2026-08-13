-- ============================================================
-- Ebook App - Database Setup Script
-- Run this in MySQL before deploying the application.
--
-- MySQL Port: 3309 (Updated to match your MySQL Workbench)
-- ============================================================

-- Step 1: Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `ebook-app`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Step 2: Use the ebook database
USE `ebook-app`;

-- Step 3: Create the user table if it doesn't exist
CREATE TABLE IF NOT EXISTS `user` (
    id       INT          NOT NULL AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR(150) NOT NULL UNIQUE,
    phone    VARCHAR(20)  DEFAULT NULL,
    password VARCHAR(255) NOT NULL,
    address  VARCHAR(255) DEFAULT NULL,
    landmark VARCHAR(100) DEFAULT NULL,
    city     VARCHAR(100) DEFAULT NULL,
    state    VARCHAR(100) DEFAULT NULL,
    pincode  VARCHAR(20)  DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Step 4: Verify
SELECT 'Database and table are ready!' AS status;
SHOW TABLES;
DESCRIBE `user`;