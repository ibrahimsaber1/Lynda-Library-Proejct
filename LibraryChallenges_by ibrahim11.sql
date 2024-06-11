/******************* In the Library *********************/

/*******************************************************/
/* find the number of availalbe copies of Dracula      */
/*******************************************************/
select (count(*) - (select COUNT(*) AS LOAND_DRACULA
from books b RIGHT join loans l on b.BookID = l.BookID
where title = 'Dracula' AND ReturnedDate IS NULL)) AS availalbe_Dracula_copies
from books
where title = 'Dracula';

/* IF U WANT TO CHEACK THE SUBQUEARY I USED IN THE QUEASTION ABOVE ... :)
select COUNT(*) AS LOAND_DRACULA
from books b RIGHT join loans l on b.BookID = l.BookID
where title = 'Dracula' AND ReturnedDate IS NULL
*/

/* check total copies of the book */
select count(*) AS total_Dracula_copies
from books
where title = 'Dracula';


/* current total loans of the book */
select COUNT(*) AS LOAND_DRACULA
from books b RIGHT join loans l on b.BookID = l.BookID
where title = 'Dracula' AND ReturnedDate IS NULL ;

/* total available book */
select (count(*) - (select COUNT(*) AS LOAND_DRACULA
from books b RIGHT join loans l on b.BookID = l.BookID
where title = 'Dracula' AND ReturnedDate IS NULL)) AS availalbe_Dracula_copies
from books
where title = 'Dracula';


/*******************************************************/
/* Add new books to the library                        */
/*******************************************************/
insert INTO books values 
(201,'python','ibrahim',2022,1234567890 );

insert INTO books values 
(202,'css','hamad',2023,1234567898 );
/*******************************************************/
/* Check out Books                                     */
/*******************************************************/
SELECT * FROM books;
-- or
SELECT * FROM books
where title = 'python';
/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/
SELECT b.BookID , b.Title, p.FirstName, p.LastName, l.DueDate , l.ReturnedDate
FROM books b join loans l on b.BookID = l.BookID
join patrons p on p.PatronID = l.PatronID
where l.DueDate = '2020-07-13';


/*******************************************************/
/* Return books to the library                         */
/*******************************************************/
-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Update the loans to mark them as returned
UPDATE loans
SET ReturnedDate = '2020-07-13'
WHERE DueDate = '2020-07-13' AND ReturnedDate IS NULL;

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;


/*******************************************************/
/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
SELECT  p.FirstName, p.LastName, count(b.BookID ) as book_count
FROM books b join loans l on b.BookID = l.BookID
join patrons p on p.PatronID = l.PatronID
group by p.FirstName ,p.LastName
order by book_count
limit 10;


/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
-- subquery to return the id of books from 1890s :
select BookID from books
where Published >= 1890;
-- the final query to return the id of books from 1890s and available :)
select *
from books b RIGHT join loans l on b.BookID = l.BookID
where ReturnedDate IS not NULL and b.BookID in (select BookID from books
where Published >= 1890);
/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks
FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC;


/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/
SELECT b.Title,COUNT(b.Title) AS TotalTimesOfLoans
FROM Books b
JOIN Loans l ON b.BookID = l.BookID
GROUP BY b.Title
ORDER BY  b.Title DESC
LIMIT 5;
