/*==================================================
    Author: Henok T.
    SQL Project : Library Managment System
====================================================*/
use LibraryManagmentSystem
go

/*===============================
========Creating the tables======
=================================*/

CREATE TABLE tbl_LibraryBranch (
  BranchID INT NOT NULL,
  BranchName VARCHAR(85),
  Address VARCHAR(85),
  PRIMARY KEY (BranchID)
  );

CREATE TABLE tbl_Publisher (
  PublisherName VARCHAR(85) NOT NULL,
  Address VARCHAR(85),
  Phone INT,
  PRIMARY KEY (PublisherName)
);

ALTER TABLE  tbl_Publisher -- Changed datatype to avoid error converting in to int while populating the table.
	ALTER COLUMN Phone VARCHAR(15) NOT NULL

CREATE TABLE tbl_Books (
  BookID INT NOT NULL,
  Title VARCHAR(85),
  PublisherName VARCHAR(85)NOT NULL CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES tbl_Publisher(PublisherName) 
                ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (BookID)
);

ALTER TABLE tbl_Books
	DROP CONSTRAINT fk_PublisherName -- deleted the constraint as it created an error while pupulating tbl_Books


CREATE TABLE tbl_Borrowers (
  CardNo INT NOT NULL,
  Name VARCHAR(85),
  Address VARCHAR(85),
  Phone INT,
  PRIMARY KEY (CardNo)
 );
 ALTER TABLE  tbl_Borrowers -- Changed datatype to avoid error converting into int while populating the table.
	ALTER COLUMN Phone VARCHAR(15) NOT NULL

CREATE TABLE tbl_BookCopies (
  BookID INT NOT NULL CONSTRAINT fk_BookID FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,                   
  BranchID INT NOT NULL CONSTRAINT fk_BranchID FOREIGN KEY REFERENCES tbl_LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
  Number_of_copies INT NOT NULL 
);

CREATE TABLE tbl_BookLoans (
  BookID INT NOT NULL CONSTRAINT fk__BKloan_BookID FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,  
  BranchID INT NOT NULL CONSTRAINT fk_BKloan_BranchID FOREIGN KEY REFERENCES tbl_LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
  CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES tbl_Borrowers(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
  DateOut DATETIME,
  DateDue DATETIME
);

CREATE TABLE tbl_BookAuthors (
  BookID INT NOT NULL CONSTRAINT fk_BkAuth_BookID FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
  AuthourName VARCHAR(85)
);

/*===============================
========Populating the tables======
=================================*/
-- 4 Library Branches
INSERT INTO tbl_LibraryBranch
	(BranchID, BranchName, Address)
	VALUES
	('1000', 'Sharpstown', '800 SW 10th Ave, Sharpstown, OR'),
	('2000', 'Belmont', '500 SE 10th Ave, Belmont, OR'),
	('3000', 'Rockwood', '100 NW 10th Ave, Rockwood, OR'),
	('4000', 'Portland', '300 NE 10th Ave,  Portland, OR')

-- Updating a library branch name
UPDATE tbl_LibraryBranch SET BranchName = 'Central' WHERE BranchID ='4000';	

-- min 20 books / 2 written by 'Stephen King'
INSERT INTO tbl_Books
	(BookID, Title, PublisherName)
	VALUES
	('01', 'The Dead Zone', 'Stephen King Publishing'),
	('02', 'Pet Sematary', 'Stephen King Publishing'),
	
    ('03', 'The President is Missing', 'Hachette Book Group'),
	('04', 'Against Medical Advice', 'Hachette Book Group'),
	('05', 'The Murder of King Tut', 'Hachette Book Group'),
	
    ('06', 'The Alice Network', 'HarperCollins Publishers'),
	('07', 'Wait, What?', 'HarperCollins Publishers'),
	('08', 'Letterman', 'HarperCollins Publishers'),
	
    ('09', 'The Rainmaker', 'Doubleday Publishing Group'),
	('10', 'The Broker', 'Doubleday Publishing Group'),
	('11', 'The Litigators', 'Doubleday Publishing Group'),
	('12', 'A Time to Kill', 'Doubleday Publishing Group'),
	('13', 'The Street Lawyer', 'Doubleday Publishing Group'),
	
    ('14', 'Harry Potter and The Philosopher-s Stone', 'Bloomsbury Publishing'),
	('15', 'Harry Potter and The Chamber of Secrets', 'Bloomsbury Publishing'),
	('16', 'Harry Potter and The Prisoner of Azkaban', 'Bloomsbury Publishing'),
	('17', 'Harry Potter and The Goblet of Fire', 'Bloomsbury Publishing'),
	('18', 'Harry Potter and The Order of the Phoenix', 'Bloomsbury Publishing'),
	('19', 'Harry Potter and The Half-Blood Prince ', 'Bloomsbury Publishing'),
	('20', 'Harry Potter and The Deathly Hallows', 'Bloomsbury Publishing')

-- added a book i forgot to include 
INSERT INTO tbl_Books (BookID, Title, PublisherName) VALUES
	('21', 'The Lost Tribe', 'Stephen King Publishing')


-- 8 borrowers 
INSERT INTO tbl_Borrowers
	(CardNo, Name, Address, Phone)
	VALUES
	('10011', 'Bob Roberts', '1st St NE Portland, OR', '503-001-1010'),
	('10200', 'Clarence Thomas', '2nd St NW Beaverton, OR', '503-002-2020'),
	('13000', 'Ruth Ginsburg', '3rd St NE Hillsboro, OR', '503-003-3030'),
	('10400', 'Stephen Breyer', '4th St NW Belmont, OR', '503-004-4040'),
	('10050', 'Sonia Sotomayor', '5th St SE Clackamas, OR', '503-005-5050'),
	('10600', 'Elena Kagan', '6th St SW Yahmill, OR', '503-006-6060'),
	('17000', 'Samuel Alito', '7th St SE Lake, OR', '503-007-7070'),
	('10800', 'Neil Gorsuch', '8th St SW Grant, OR', '503-008-8080')


INSERT INTO tbl_BookAuthors
	(BookID, AuthourName)
	VALUES
	(01, 'Stephen King'),
	(02, 'Stephen King'),
	(03, 'James Patterson'),
	(04, 'James Patterson'),	
	(05, 'James Patterson'),
	(06, 'Kate Quinn'),
	(07, 'James E. Ryan'),
	(08, 'Jason Zinoman'),
	(09, 'John Grisham'),
	(10, 'John Grisham'),
	(11, 'John Grisham'),
	(12, 'Vin Baker and Joe Layden'),
	(13, 'Vin Baker and Joe Layden'),
	(14, 'J. K. Rowling'),
	(15, 'J. K. Rowling'),
	(16, 'J. K. Rowling'),
	(17, 'J. K. Rowling'),
	(18, 'J. K. Rowling'),
	(19, 'Sandra Aamodt'),
	(20, 'Julia Hobsbawm')

-- added a book's author i forgot to include 
INSERT INTO tbl_BookAuthors (BookID, AuthourName) VALUES
	(21, 'Mark Lee')

-- 5 Publishers 
INSERT INTO tbl_Publisher
    (PublisherName, Address, Phone)
	VALUES
	('Stephen King Publishing', '21st St NE Washington, D.C.', 101-111-1011),
	('Hachette Book Group', '22nd St NW Washington, D.C.', 202-222-2022),
	('HarperCollins Publishers', '33rd St NE Washington, D.C.', 303-333-3033),
	('Doubleday Publishing Group', '44th St NW Washington, D.C.', 404-444-4044),
	('Bloomsbury Publishing', '55th St SE Washington, D.C.', 505-555-5055)

--  Updated the phone column values to bypass error converting into int 
UPDATE tbl_Publisher SET Phone = '101-111-1011' WHERE PublisherName ='Stephen King Publishing';	
UPDATE tbl_Publisher SET Phone = '202-222-2022' WHERE PublisherName = 'Hachette Book Group';	
UPDATE tbl_Publisher SET Phone = '303-333-3033' WHERE PublisherName ='HarperCollins Publishers';	
UPDATE tbl_Publisher SET Phone = '404-444-4044' WHERE PublisherName ='Doubleday Publishing Group';	
UPDATE tbl_Publisher SET Phone = '505-555-5055' WHERE PublisherName ='Bloomsbury Publishing';	

-- 10 book titles (2 copies of each) for each Library Branch & Central branch have 2 books written by Stephen King.   
    
INSERT INTO tbl_BookCopies
	(BookID, BranchID, Number_of_copies)
	VALUES
	(01, 1000, 2),
	(02, 1000, 2),
	(03, 1000, 2),
	(04, 1000, 2),
	(05, 1000, 2),
	(06, 1000, 2),
	(07, 1000, 2),
	(08, 1000, 2),
	(09, 1000, 2),
	(10, 1000, 2),
    
    (11, 2000, 2),
	(12, 2000, 2),
	(13, 2000, 2),
	(14, 2000, 2),
	(15, 2000, 2),
	(16, 2000, 2),
	(17, 2000, 2),
	(18, 2000, 2),
	(19, 2000, 2),
	(20, 2000, 2),
    
	(11, 3000, 2),
	(12, 3000, 2),
	(03, 3000, 2),
	(04, 3000, 2),
	(05, 3000, 2),
	(06, 3000, 2),
	(07, 3000, 2),
	(08, 3000, 2),
	(09, 3000, 2),
	(10, 3000, 2),
    
	(01, 4000, 2),
	(02, 4000, 2),
	(13, 4000, 2),
	(14, 4000, 2),
	(15, 4000, 2),
	(16, 4000, 2),
	(17, 4000, 2),
	(18, 4000, 2),
	(19, 4000, 2),
	(20, 4000, 2)

-- added a book i forgot to include 
INSERT INTO tbl_BookCopies (BookID, BranchID, Number_of_copies) VALUES
	(21, 1000, 2),
	(21, 2000, 2)

-- min 50 loans 
INSERT INTO tbl_BookLoans
	(BookID, BranchID, CardNo, DateOut, DateDue)
	VALUES
    (01, 1000, 10010, '2018-10-25', '2018-12-01'),
    (02, 1000, 10010, '2018-10-25', '2018-12-01'),
	(03, 1000, 10010, '2018-10-25', '2018-12-01'),
	(04, 1000, 10010, '2018-10-25', '2018-12-01'),
	(05, 1000, 10010, '2018-10-25', '2018-12-01'),
    (06, 1000, 10010, '2018-10-25', '2018-12-01'),
    (07, 1000, 10010, '2018-10-26', '2018-12-02'),
    (08, 1000, 10010, '2018-10-26', '2018-12-02'),
	(09, 1000, 10010, '2018-10-26', '2018-12-02'),
	(10, 1000, 10010, '2018-10-26', '2018-12-02'),
    (11, 1000, 10010, '2018-10-26', '2018-12-02'),
	(12, 1000, 10010, '2018-10-26', '2018-12-02'),
    
	(13, 2000, 10200, '2018-10-26', '2018-12-02'),
    (14, 2000, 10200, '2018-10-26', '2018-12-02'),
	(15, 2000, 10200, '2018-10-26', '2018-12-02'),
	(16, 2000, 10200, '2018-10-26', '2018-12-02'),
    (17, 2000, 10200, '2018-10-26', '2018-12-02'),
	(18, 2000, 10200, '2018-10-26', '2018-12-02'),
    (19, 2000, 10200, '2018-10-26', '2018-12-02'),
	(20, 2000, 10200, '2018-10-26', '2018-12-02'),
    (21, 2000, 10200, '2018-10-26', '2018-12-02'),
	(01, 2000, 10200, '2018-10-26', '2018-12-02'),
    
	(02, 3000, 13000, '2018-10-27', '2018-12-03'), 
	(03, 3000, 10400, '2018-10-27', '2018-12-03'), 
	(04, 3000, 10050, '2018-10-27', '2018-12-03'), 
	(05, 3000, 10600, '2018-10-27', '2018-12-03'), 
	(06, 3000, 17000, '2018-10-27', '2018-12-03'),
	(07, 3000, 10800, '2018-10-27', '2018-12-03'),
    (08, 3000, 13000, '2018-10-27', '2018-12-03'),
	(09, 3000, 10400, '2018-10-27', '2018-12-03'),
	(10, 3000, 10050, '2018-10-27', '2018-12-03'),
	(11, 3000, 10600, '2018-10-27', '2018-12-03'),

	(12, 4000, 13000,  '2018-10-28', '2018-12-04'),
	(13, 4000, 13000,  '2018-10-28', '2018-12-04'),
	(14, 4000, 10400,  '2018-10-28', '2018-12-04'),
	(15, 4000, 10400,  '2018-10-28', '2018-12-04'),
	(16, 4000, 10050,  '2018-10-28', '2018-12-04'),
	(17, 4000, 10050,  '2018-10-28', '2018-12-04'),
	(18, 4000, 10600,  '2018-10-28', '2018-12-04'),
	(19, 4000, 10600,  '2018-10-28', '2018-12-04'),
	(20, 4000, 17000,  '2018-10-28', '2018-12-04'),
    
	(21, 3000, 13000,  '2018-10-29', '2018-12-05'),
	(01, 3000, 13000,  '2018-10-29', '2018-12-05'),
	(03, 3000, 10400,  '2018-10-29', '2018-12-05'),
	(04, 3000, 10400,  '2018-10-29', '2018-12-05'),
	(05, 3000, 10050,  '2018-10-29', '2018-12-05'),
	(06, 4000, 10050,  '2018-10-29', '2018-12-05'),
	(07, 4000, 10600,  '2018-10-29', '2018-12-05'),
	(08, 4000, 10600,  '2018-10-29', '2018-12-05'),
	(09, 4000, 17000,  '2018-10-29', '2018-12-05'),
	(10, 4000, 10800,  '2018-10-29', '2018-12-05')	

/*================================================================================================
========STORED PROCEDURES THAT QUERY FOR EACH OF THE FOLLOWING QUESTIONS:=========================
=================================================================================================*/
	
/* 1.How many copies of the book titled "The Lost Tribe" are owned 
by the library branch whose name is "Sharpstown"?*/

CREATE PROCEDURE HowManyCopies
AS
SELECT Number_of_copies, BranchName, Title FROM tbl_BookCopies
INNER JOIN tbl_LibraryBranch ON tbl_LibraryBranch.BranchID = tbl_BookCopies.BranchID
INNER JOIN tbl_Books ON tbl_Books.BookID = tbl_BookCopies.BookID
WHERE BranchName = 'Sharpstown' And Title = 'The Lost Tribe'


/* 2.How many copies of the book titled "The Lost Tribe" 
are owned by each library branch?*/

CREATE PROCEDURE Copies_BookLostTribe_allBranch
AS
SELECT Number_of_copies, BranchName, Title FROM tbl_BookCopies
INNER JOIN tbl_LibraryBranch ON tbl_LibraryBranch.BranchID = tbl_BookCopies.BranchID
INNER JOIN  tbl_Books ON tbl_Books.BookID = tbl_BookCopies.BookID
Where Title = 'The Lost Tribe'

/*3. Retrieve the names of all borrowers who do not have any books checked out.*/

CREATE PROCEDURE borrower_no_checkedOut
AS
SELECT  Name, DateOut  FROM tbl_BookLoans
FULL OUTER JOIN tbl_Borrowers ON tbl_Borrowers.CardNo = tbl_BookLoans.CardNo
FULL OUTER JOIN  tbl_Books ON tbl_Books.BookID = tbl_BookLoans.BookID
WHERE DateOut IS NULL


/* 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, 
retrieve the book title, the borrower's name, and the borrower's address.*/

CREATE PROCEDURE borrower_Sharptown_Duedate_today
AS
SELECT tbl_Borrowers.Name, tbl_Borrowers.Address, Title  FROM tbl_BookLoans
Inner JOIN tbl_Books ON tbl_Books.BookID = tbl_BookLoans.BookID
INNER JOIN tbl_Borrowers ON tbl_Borrowers.CardNo = tbl_BookLoans.CardNo  
INNER JOIN tbl_LibraryBranch ON tbl_LibraryBranch.BranchID = tbl_BookLoans.BranchID
WHERE BranchName = 'Sharpstown'
And DateDue = '2018-12-02' -- assuming today is December 2nd !!

/* Or we can use the getdate() function as an alternative too,
 [like so: And DateDue = CAST(GETDATE()AS DATE) ]
But it wont generate any result set, cos all my due dates fall between dec 01-05 */

/* 5. For each library branch, retrieve the branch name and the total number of books 
loaned out from that branch.*/

CREATE PROCEDURE TotalBooksLoaned_AllBranches
AS
SELECT BranchName, COUNT(BookID) as Total_Books_Loaned FROM tbl_BookLoans
FULL JOIN tbl_LibraryBranch ON tbl_LibraryBranch.BranchID = tbl_BookLoans.BranchID  
Group by BranchName

/*6. Retrieve the names, addresses, and the number of books checked out for all borrowers 
who have more than five books checked out.*/

CREATE PROCEDURE Borrowers_WithMoreThan_5Books
AS
SELECT  Name, Address, COUNT(BookID) as Total_Books_Loaned FROM tbl_BookLoans  
INNER JOIN tbl_Borrowers  ON tbl_Borrowers.CardNo = tbl_BookLoans.CardNo
group by Name, Address
having COUNT(BookID) > 5

/* We will get 6 borrowers with more than 5 books checked out to them. 
As the Stored procedure is functioning well, I don't seeany need to update
 the tbl_BookLoans in order to get exactly 2 borrowers. */

/*7. For each book authored (or co-authored) by "Stephen King", retrieve the title and
 the number of copies owned by the library branch whose name is "Central".*/

CREATE PROCEDURE BooksBy_SK_onBranchCentral
AS
SELECT tbl_Books.Title, tbl_BookCopies.Number_of_copies as Total_Books FROM tbl_Books
INNER JOIN tbl_BookAuthors  ON tbl_BookAuthors.BookID = tbl_Books.BookID
INNER JOIN tbl_BookCopies ON tbl_BookCopies.BookID = tbl_Books.BookID
INNER JOIN tbl_LibraryBranch ON tbl_LibraryBranch.BranchID = tbl_BookCopies.BranchID
Where AuthourName = 'Stephen King'
And BranchName = 'Central'