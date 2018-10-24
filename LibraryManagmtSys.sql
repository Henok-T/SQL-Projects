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
 ALTER TABLE  tbl_Borrowers -- Changed datatype to avoid  error converting in to int while populating the table.
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

-- 20 books / 2 written by 'Stephen King'
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

-- 8 borrowers 
INSERT INTO tbl_Borrowers
	(CardNo, Name, Address, Phone)
	VALUES
	('10010', 'John Roberts', '1st St NE Portland, OR', '503-001-1010'),
	('10200', 'Clarence Thomas', '2nd St NW Beaverton, OR', '503-002-2020'),
	('13000', 'Ruth Ginsburg', '3rd St NE Hillsboro, OR', '503-003-3030'),
	('10400', 'Stephen Breyer', '4th St NW Belmont, OR', '503-004-4040'),
	('10050', 'Sonia Sotomayor', '5th St SE Clackamas, OR', '503-005-5050'),
	('10600', 'Elena Kagan', '6th St SW Yahmill, OR', '503-006-6060'),
	('17000', 'Samuel Alito', '7th St SE Lake, OR', '503-007-7070'),
	('10800', 'Neil Gorsuch', '8th St SW Grant, OR', '503-008-8080')


SELECT * FROM tbl_Borrowers order by Name