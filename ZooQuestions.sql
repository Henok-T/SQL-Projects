use db_zoo
--1.)
--Compose a SELECT statement that queries for the following information:

-- All information from the habitat table

SELECT * FROM tbl_habitat;


--2.)
--Compose a SELECT statement that queries for the following information:

-- Retrieve all names from the species_name column that have a species_order value of 3.

SELECT tbl_species.species_name 
FROM tbl_species
WHERE tbl_species.species_order = 3;

--3.) 
--Compose a SELECT statement that queries for the following information:

--Retrieve only the nutrition_type from the nutrition table that have a nutrition_cost of 600.00 or less.

SELECT tbl_nutrition.nutrition_type, tbl_nutrition.nutrition_cost 
FROM tbl_nutrition
WHERE tbl_nutrition.nutrition_cost <= 600;

--4.)
--Compose a SELECT statement that queries for the following information:

-- Retrieve all species_names with the nutrition_id between 2202 and 2206 from the nutrition table.

SELECT tbl_species.species_name, tbl_nutrition.nutrition_id
FROM tbl_species
INNER JOIN tbl_nutrition ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id
WHERE tbl_nutrition.nutrition_id >= 2202 AND tbl_nutrition.nutrition_id <= 2206
ORDER BY tbl_nutrition.nutrition_id;

SELECT tbl_species.species_name, tbl_nutrition.nutrition_id
FROM tbl_species
INNER JOIN tbl_nutrition ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id
WHERE tbl_nutrition.nutrition_id BETWEEN 2202 AND 2206
ORDER BY tbl_nutrition.nutrition_id;

--5.)
--Compose a SELECT statement that queries for the following information:

-- Retrieve all names within the species_name column using the alias "Species Name:" 
--from the species table and their corresponding nutrition_type under the alias 
--"Nutrition Type:" from the nutrition table.

SELECT tbl_species.species_name AS [Species Name:], tbl_nutrition.nutrition_type AS [Nutrition Type:]
FROM tbl_species
INNER JOIN tbl_nutrition ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id

--6.)
--Compose a SELECT statement that queries for the following information:

--From the specialist table, retrieve the first and last name and contact number of 
--those that provide care for the penguins from the species table.

SELECT ist.specialist_fname AS [Specialist first name], ist.specialist_lname, ist.specialist_contact, tbl_species.species_name 
FROM tbl_specialist AS ist
INNER JOIN tbl_care ON ist.specialist_id = tbl_care.care_specialist
INNER JOIN tbl_species ON tbl_care.care_id = tbl_species.species_care
WHERE tbl_species.species_name = 'penguin';

SELECT tbl_specialist.specialist_fname, tbl_specialist.specialist_lname, tbl_specialist.specialist_contact, tbl_species.species_name 
FROM tbl_specialist
INNER JOIN tbl_care ON tbl_specialist.specialist_id = tbl_care.care_specialist
INNER JOIN tbl_species ON tbl_care.care_id = tbl_species.species_care
WHERE tbl_species.species_name = 'penguin';

--7.)
--Create your own table. Build a select statement that queries for the following information:

--Create a database with two tables. Assign a foreign key constraint on one table that shares
-- related data with the primary key on the second table. Finally, create a statement that 
--queries data from both tables.

USE DbDrill
--DROP TABLE papertype
--DROP TABLE papercolor

--CREATE TABLE papertype(
--idno INT IDENTITY(1,1) PRIMARY KEY,
--title VARCHAR(100)

--);

--CREATE TABLE papercolor(
--idno INT FOREIGN KEY REFERENCES papertype(idno),
--color VARCHAR(15)

--);

--INSERT INTO papertype (title)
--VALUES ('newspaper'), ('magazine paper'), ('book paper'); 
--INSERT INTO papercolor (idno, color)
--VALUES (1,'grey'), (2,'colorful'), (3,'tan');
SELECT * FROM papercolor
SELECT * FROM papertype

SELECT * FROM papertype
INNER JOIN papercolor ON papertype.idno = papercolor.idno;

