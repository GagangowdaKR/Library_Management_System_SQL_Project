DROP database if exists library_management_system;
Create Database library_management_system;
use library_management_system;

CREATE TABLE user(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
	user_type VARCHAR(100)
);

CREATE TABLE author(
	author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE category(
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE book(
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    author_id INT,
    category_id INT,
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE book_issues(
	issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    user_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
	FOREIGN KEY (user_id) REFERENCES user(user_id)
);