CREATE DATABASE IF NOT EXISTS ebook;
USE ebook;

CREATE TABLE IF NOT EXISTS user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phno VARCHAR(20),
    password VARCHAR(100),
    address VARCHAR(255),
    landmark VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS book_details (
    bookId INT PRIMARY KEY AUTO_INCREMENT,
    bookname VARCHAR(150),
    author VARCHAR(100),
    price VARCHAR(50),
    bookCategory VARCHAR(50),
    status VARCHAR(50),
    photo VARCHAR(255),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS book_order (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(100),
    user_name VARCHAR(100),
    email VARCHAR(100),
    phno VARCHAR(20),
    address VARCHAR(255),
    book_name VARCHAR(150),
    author VARCHAR(100),
    price VARCHAR(50),
    payment VARCHAR(50)
);