USE library_management_system;
show tables;

-- 1. List all books with their author and category.
select b.title, a.name as author, c.name as category
from book b
join author a
on b.author_id = a.author_id
join category c
on b.category_id = c.category_id; 

-- 2. Show members and the books they’ve borrowed
select u.name, b.title 
from user u
join book_issues bi
on u.user_id = bi.user_id
join book b
on b.book_id = bi.book_id;

-- 3. Count how many books are available per category.
select c.category_id, c.name as category, count(*) as 'Total Books'
from category c
join book b
on c.category_id = b.category_id
group by b.category_id;

-- 4. List books currently on loan (return_date IS NULL).
select b.book_id, b.title 
from book b
join book_issues bi
on b.book_id = bi.book_id
where bi.return_date is null;

-- 5. Find members who borrowed books after a specific date.
select u.name as User, b.title as Book, bi.issue_date
from user u
join book_issues bi
on u.user_id = bi.user_id
join book b
on b.book_id = bi.book_id
where bi.issue_date > '2025-07-06';

-- 6. Use INNER JOIN to show book titles with author names.
select b.book_id, b.title, a.name as author 
from book b
inner join author a
on b.author_id = a.author_id;

-- 7. Use a subquery to list books that are not currently borrowed.
select b.book_id, b.title 
from book b
where b.book_id not in (select book_id from book_issues);

-- 8. Count how many books are borrowed by each member.
select u.user_id, u.name as UserName, count(*) Total_Books 
from user u
join book_issues bi
on u.user_id = bi.user_id
group by (u.user_id);

-- 9. Find the most borrowed book using a subquery.
select b.book_id, b.title, (select count(*) from book_issues where book_id = b.book_id) as Borrow
from book b 
where b.book_id = (
	select bi.book_id
    from book_issues bi 
    group by bi.book_id 
    order by count(*) desc 
    limit 1
);
-- 	OR
select bi.book_id as Book_Id, (select b.title from book b where b.book_id = bi.book_id) as Book_Name, count(*) Borrow 
from book_issues bi
group by bi.book_id
order by Borrow desc limit 1;

-- 10. Create a view for current loans with book title, member name, loan date.
drop view if exists current_loans; 
create view current_loans as select b.title, u.name as User, bi.issue_date as loan_date
from book b
join book_issues bi
on b.book_id = bi.book_id
join user u
on u.user_id = bi.user_id
where bi.return_date is null;

select * from current_loans;

-- 11. Display the latest 5 books.
		-- 5 latest issued books 
select b.book_id, b.title, bi.issue_date
from book b
join book_issues bi
on b.book_id = bi.book_id
order by bi.issue_date desc limit 5;

-- 12. Show books in pages of 10.
select * from book limit 0,10;

-- 13. Add indexes on foreign key columns and explain why.
		-- Indexes on foreign key columns are not automatically created by MySQL (unlike primary keys), but they are strongly recommended for performance and integrity reasons:
        -- 1. Improved JOIN Performance
        -- 2. Faster WHERE and SELECT Queries
show index from book;
show index from book_issues;

create index idx_author_id on book(author_id);
create index idx_category_id on book(category_id);

create index idx_book_id on book_issues(book_id);
create index idx_user_id on book_issues(user_id);

explain select u.user_id, count(*) total
		from user u
        join book_issues bi
        on u.user_id = bi.user_id
        join book b
        on b.book_id = bi.book_id
        group by bi.user_id
        having count(*)>1;

-- 14. Use UNION to combine author and member names.
select name, "Author" from author 
union 
select name, "User" from user;

-- 15. Find members who borrowed more books than average (advanced subquery).
select u.user_id, u.name, count(*) as Total_books
from user u 
join book_issues bi
on u.user_id = bi.user_id
group by bi.user_id having count(*) > (
	select avg(TotalBooks)
	from (select count(*) as TotalBooks from book_issues group by user_id) 
	as dummy
);

-- 16. Find the top 3 most borrowed books.
select b.book_id, b.title, count(*)
from book b
join book_issues bi
on b.book_id = bi.book_id
group by bi.book_id
order by count(*) desc
limit 3;

-- 17. List members who have borrowed books from more than one category.
select u.user_id, u.name, count(distinct b.category_id) as Total_Category
from user u
join book_issues bi
on bi.user_id = u.user_id
join book b
on b.book_id = bi.book_id
group by u.user_id 
having count(distinct b.category_id) > 1;

-- 18. Find books that were borrowed and returned within 7 days.
select b.book_id, b.title, bi.issue_date, bi.return_date
from book b
join book_issues bi
on b.book_id = bi.book_id
where bi.return_date - bi.issue_date < 7;

-- 19. Display books that have never been borrowed.
select b.book_id, b.title
from book b 
where book_id not in (
	select book_id from book_issues
);

-- 20. List each member’s most recently borrowed book.
select bi.user_id, u.name, bi.book_id, b.title, bi.issue_date
from user u
join book_issues bi
on bi.user_id = u.user_id
join book b
on b.book_id = bi.book_id
where bi.issue_date = (
	select issue_date
    from book_issues
    where user_id = bi.user_id
	order by issue_date desc
    limit 1
);

-- *********************************************************** --
select * from user;
select * from book;
select * from author;
select * from category;
select * from book_issues;