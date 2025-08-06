use library_management_system;

INSERT INTO user(name, email, user_type) VALUES
('Gagan K R', 'gagan@gmail.com', 'regular'),
('darshi K R', 'darshi@gmail.com', 'regular'),
('Yashu', 'yashu12@gmail.com', 'part time'),
('charan', 'chari55@gmail.com', 'regular'),
('sahana', 'sahana1@gmail.com', 'part time'),
('Rashmi N', 'rash123@gmail.com', 'regular'),
('Sai Kiran', 'sai32@gmail.com', 'part time'),
('prajwal', 'nj123@gmail.com', 'regular'),
('Zuber', 'zuber@gmail.com', 'part time'),
('Raju K', 'raju@gmail.com', 'regular');

INSERT INTO author (name) VALUES
('J.K. Rowling'),
('George Orwell'),
('J.R.R. Tolkien'),
('Agatha Christie'),
('Stephen King'),
('Dan Brown'),
('C.S. Lewis'),
('Jane Austen'),
('Mark Twain'),
('Ernest Hemingway');

INSERT INTO category (name) VALUES
('Fiction'),
('Mystery'),
('Fantasy'),
('Science Fiction'),
('Biography'),
('Romance'),
('Thriller'),
('Classic'),
('Adventure'),
('Historical');

INSERT INTO book (title, author_id, category_id) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 3),
('1984', 2, 4),
('The Hobbit', 3, 3),
('Murder on the Orient Express', 4, 2),
('The Shining', 5, 7),
('The Da Vinci Code', 6, 7),
('The Lion, the Witch and the Wardrobe', 7, 3),
('Pride and Prejudice', 8, 6),
('Adventures of Huckleberry Finn', 9, 9),
('The Old Man and the Sea', 10, 8);


INSERT INTO book_issues (book_id, user_id, issue_date, return_date) VALUES
(1, 3, '2025-07-01', '2025-07-15'),
(2, 2, '2025-07-02', '2025-07-18'),
(3, 3, '2025-07-03', '2025-07-17'),
(4, 4, '2025-07-04', '2025-07-20'),
(5, 5, '2025-07-05', '2025-07-22'),
(6, 6, '2025-07-06', '2025-07-21'),
(7, 5, '2025-07-07', '2025-07-25'),
(8, 8, '2025-07-08', '2025-07-23'),
(9, 9, '2025-07-09', '2025-07-26'),
(10, 1, '2025-07-10', '2025-07-27');

insert into book_issues (book_id, user_id, issue_date, return_date) VALUES (2, 2, '2025-07-10', null);
update book_issues set return_date = null where issue_id = 7;

update book_issues set issue_date = '2025-08-05' where issue_id = 11;
update book_issues set issue_date = '2024-04-05' where issue_id = 9;
update book_issues set issue_date = '2025-07-06' where issue_id = 5;

update book set author_id = 3 where book_id = 5;

update book_issues set book_id = 8 where issue_id = 6;

insert into book_issues (book_id, user_id, issue_date, return_date) VALUES 
(4, 2, '2025-06-10', '2025-07-10'),
(3, 2, '2025-07-02', '2025-07-15'),
(8, 2, '2025-07-02', '2025-07-15');


show tables;

select * from user;
select * from book;
select * from author;
select * from category;
select * from book_issues;
