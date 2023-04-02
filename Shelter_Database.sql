﻿USE master
GO
if exists (select * from sysdatabases where name='Shelters')
	DROP DATABASE Shelters
GO

CREATE DATABASE Shelters
GO
USE Shelters
GO


------- Create Tables -------
CREATE TABLE ANIMALS (
    ANIMAL_ID CHAR(10) NOT NULL,
    ANIMAL_NAME VARCHAR(20),
    BREED VARCHAR(20) NOT NULL,
    SPECIES VARCHAR(20) NOT NULL,
	AGE INTEGER NOT NULL CHECK (AGE >= 0 AND AGE <=100), 
    SHELTER_ADDRESS VARCHAR(30) NOT NULL,
    TOWN_NAME VARCHAR(20) NOT NULL
);

CREATE TABLE TOWNS (
    NAME VARCHAR(20) NOT NULL 
);

CREATE TABLE CLIENTS (
    CLIENT_ID CHAR(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(20),
	PHONE_NUMBER CHAR (15) NOT NULL,
	TYPE_CLIENT VARCHAR (20) NOT NULL CHECK (UPPER(TYPE_CLIENT) IN ('VOLUNTEER', 'ADOPTER', 'VOLUNTEER_ADOPTER', 'ADOPTER_VOLUNTEER', 'ADOPTERVOLUNTEER', 'VOLUNTEERADOPTER'))
);

-- В check са добавени много типове с различен начин на писане, 
-- за да се даде повече свобода на потребителя да може да ги добавя по различен начин написани

-- CREATE TABLE CLIENTS_VOLUNTEERS (
--    CLIENT_ID CHAR(10) NOT NULL,
--	NAME VARCHAR(20) NOT NULL,
--	EMAIL VARCHAR(20),
--	PHONE_NUMBER CHAR (15) NOT NULL
--);

-- CREATE TABLE CLIENTS_ADOPTERS (
--    CLIENT_ID CHAR(10) NOT NULL,
--	NAME VARCHAR(20) NOT NULL,
--	EMAIL VARCHAR(20),
--	PHONE_NUMBER CHAR (15) NOT NULL
--);

-- CREATE TABLE CLIENTS_VOLUNTEERS_ADOPTERS (
--    CLIENT_ID CHAR(10) NOT NULL,
--	NAME VARCHAR(20) NOT NULL,
--	EMAIL VARCHAR(20),
--	PHONE_NUMBER CHAR (15) NOT NULL
--);

CREATE TABLE PERSONNEL (
    PRIVATE_ID CHAR(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	PHONE_NUMBER CHAR(15) NOT NULL,
	SHELTER_ADDRESS VARCHAR(30) NOT NULL,
	TOWN_NAME VARCHAR(20) NOT NULL
);

CREATE TABLE ANIMAL_KEEPERS (
    PRIVATE_ID CHAR(10) NOT NULL
);

CREATE TABLE STAFF (
    PRIVATE_ID CHAR(10) NOT NULL
);

CREATE TABLE SHELTERS (
    ADDRESS VARCHAR(30) NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	TOWN_NAME VARCHAR(20) NOT NULL
);

CREATE TABLE TAKES_CARE (
	ANIMAL_ID CHAR(10) NOT NULL,
    PRIVATE_ID CHAR(10) NOT NULL
);

CREATE TABLE ADOPTS (
	SHELTER_ADDRESS VARCHAR(30) NOT NULL,
	TOWN_NAME VARCHAR(20) NOT NULL,
	ANIMAL VARCHAR(20) NOT NULL,
	DATE VARCHAR(30) NOT NULL,
	CLIENT_ID CHAR(10) NOT NULL
 );

CREATE TABLE VISITS (
	SHELTER_ADDRESS VARCHAR(30) NOT NULL,
	TOWN_NAME VARCHAR(20) NOT NULL,
	CLIENT_ID CHAR(10) NOT NULL
);

CREATE TABLE GIVES_FOR_ADOPTION (
	SHELTER_ADDRESS VARCHAR(30) NOT NULL,
	TOWN_NAME VARCHAR(20) NOT NULL,
	ANIMAL VARCHAR(20) NOT NULL,
	DATE VARCHAR(30) NOT NULL,
	CLIENT_ID CHAR(10) NOT NULL
);

CREATE TABLE SERVICE (
    PRIVATE_ID CHAR(10) NOT NULL,
	CLIENT_ID CHAR(10) NOT NULL
);

------- Create Constraints For Primary Key -------

ALTER TABLE ANIMALS
ADD CONSTRAINT PK_ANIMALS PRIMARY KEY(ANIMAL_ID);

ALTER TABLE TOWNS
ADD CONSTRAINT PK_TOWNS PRIMARY KEY(NAME);

ALTER TABLE CLIENTS
ADD CONSTRAINT PK_CLIENTS PRIMARY KEY(CLIENT_ID);

--ALTER TABLE CLIENTS_VOLUNTEERS
--ADD CONSTRAINT PK_CLIENTS_VOLUNTEERS PRIMARY KEY(CLIENT_ID);

--ALTER TABLE CLIENTS_ADOPTERS
--ADD CONSTRAINT PK_CLIENTS_ADOPTERS PRIMARY KEY(CLIENT_ID);

--ALTER TABLE CLIENTS_VOLUNTEERS_ADOPTERS
--ADD CONSTRAINT PK_CLIENTS_VOLUNTEERS_ADOPTERS PRIMARY KEY(CLIENT_ID);

ALTER TABLE PERSONNEL
ADD CONSTRAINT PK_PERSONNEL PRIMARY KEY(PRIVATE_ID);

ALTER TABLE ANIMAL_KEEPERS
ADD CONSTRAINT PK_ANIMAL_KEEPERS PRIMARY KEY(PRIVATE_ID);

ALTER TABLE STAFF
ADD CONSTRAINT PK_STAFF PRIMARY KEY(PRIVATE_ID);

ALTER TABLE SHELTERS
ADD CONSTRAINT PK_SHELTERS PRIMARY KEY(ADDRESS, TOWN_NAME);

ALTER TABLE TAKES_CARE
ADD CONSTRAINT PK_TAKES_CARE PRIMARY KEY(ANIMAL_ID, PRIVATE_ID);

ALTER TABLE ADOPTS
ADD CONSTRAINT PK_ADOPTS PRIMARY KEY(SHELTER_ADDRESS, TOWN_NAME, CLIENT_ID);

ALTER TABLE VISITS
ADD CONSTRAINT PK_VISITS PRIMARY KEY(SHELTER_ADDRESS, TOWN_NAME, CLIENT_ID);

ALTER TABLE GIVES_FOR_ADOPTION
ADD CONSTRAINT PK_GIVES_FOR_ADOPTION PRIMARY KEY(SHELTER_ADDRESS, TOWN_NAME, CLIENT_ID);

ALTER TABLE SERVICE
ADD CONSTRAINT PK_SERVICE PRIMARY KEY(PRIVATE_ID, CLIENT_ID);


------- Create Constraints For Foreign Key -------

ALTER TABLE ANIMALS
ADD CONSTRAINT FK_ANIMALS_SHELTERS FOREIGN KEY(SHELTER_ADDRESS, TOWN_NAME) REFERENCES SHELTERS(ADDRESS, TOWN_NAME); 

ALTER TABLE PERSONNEL
ADD CONSTRAINT FK_PERSONNEL_SHELTERS FOREIGN KEY(SHELTER_ADDRESS, TOWN_NAME) REFERENCES SHELTERS(ADDRESS, TOWN_NAME);

ALTER TABLE TAKES_CARE
ADD CONSTRAINT FK_TAKES_CARE_ANIMALS FOREIGN KEY(ANIMAL_ID) REFERENCES ANIMALS(ANIMAL_ID); 

ALTER TABLE TAKES_CARE
ADD CONSTRAINT FK_TAKES_CARE_ANIMAL_KEEPERS FOREIGN KEY(PRIVATE_ID) REFERENCES ANIMAL_KEEPERS(PRIVATE_ID);

ALTER TABLE ADOPTS
ADD CONSTRAINT FK_ADOPTS_SHELTERS FOREIGN KEY(SHELTER_ADDRESS, TOWN_NAME) REFERENCES SHELTERS(ADDRESS, TOWN_NAME);

ALTER TABLE ADOPTS
ADD CONSTRAINT FK_ADOPTS_CLIENTS FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(CLIENT_ID);

ALTER TABLE VISITS
ADD CONSTRAINT FK_VISITS_SHELTERS FOREIGN KEY(SHELTER_ADDRESS, TOWN_NAME) REFERENCES SHELTERS(ADDRESS, TOWN_NAME);

ALTER TABLE VISITS
ADD CONSTRAINT FK_VISITS_CLIENTS FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(CLIENT_ID);

ALTER TABLE GIVES_FOR_ADOPTION
ADD CONSTRAINT FK_GIVES_FOR_ADOPTION_SHELTERS FOREIGN KEY(SHELTER_ADDRESS, TOWN_NAME) REFERENCES SHELTERS(ADDRESS, TOWN_NAME);

ALTER TABLE GIVES_FOR_ADOPTION
ADD CONSTRAINT FK_GIVES_FOR_ADOPTION_CLIENTS FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(CLIENT_ID);

ALTER TABLE SERVICE
ADD CONSTRAINT FK_SERVICE_STAFF FOREIGN KEY(PRIVATE_ID) REFERENCES STAFF(PRIVATE_ID);

ALTER TABLE SERVICE
ADD CONSTRAINT FK_SERVICE_CLIENTS FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(CLIENT_ID);



 ------- Insert into Tables -------
INSERT INTO TOWNS
	VALUES ('Sofia');

INSERT INTO TOWNS
	VALUES ('Vidin');

INSERT INTO TOWNS
	VALUES ('Shumen');

INSERT INTO TOWNS
	VALUES ('Varna');

INSERT INTO TOWNS
	VALUES ('Pleven');



INSERT INTO SHELTERS
	VALUES ('James Boucher 14', 'PetMe','Sofia');

INSERT INTO SHELTERS
	VALUES ('Aleksander Todorov 15', 'Animal Care','Shumen');

INSERT INTO SHELTERS
	VALUES ('Todor Kablev 10', 'Animal Hope','Varna');

INSERT INTO SHELTERS
	VALUES ('Tsar Simeon Veliki', 'Save Animals','Vidin');

INSERT INTO SHELTERS
	VALUES ('San Stefano', '4 Paws','Pleven');



INSERT INTO CLIENTS
	VALUES (343565, 'Iliyan', 'iliyan@gmail.com', 0881722431, 'adopter');

INSERT INTO CLIENTS
	VALUES (436735, 'Ivana', 'ivana@gmail.com', 0882167411, 'adopter');

INSERT INTO CLIENTS
	VALUES (837462, 'Mihaela', 'mihaela@gmail.com', 0882167521, 'adopter');

INSERT INTO CLIENTS
	VALUES (223443, 'Alex', 'alex@gmail.com', 0882123421, 'adopter');

INSERT INTO CLIENTS
	VALUES (343215, 'Silviya', 'silviya@gmail.com', 087213421, 'adopter');

INSERT INTO CLIENTS
	VALUES (213542, 'Ivan', 'ivan@gmail.com', 088324234, 'volunteer');

INSERT INTO CLIENTS
	VALUES (765878, 'Stefan', 'stefan@gmail.com', 0889121323, 'volunteer');

INSERT INTO CLIENTS
	VALUES (132134, 'Alexandur', 'alexandur@gmail.com', 088022383, 'volunteer');

INSERT INTO CLIENTS
	VALUES (1343254, 'Tihomir', 'tihomir@gmail.com', 084325824, 'volunteer');

INSERT INTO CLIENTS
	VALUES (8895426, 'Silvester', 'silvester@gmail.com', 0879073143, 'volunteer');

INSERT INTO CLIENTS
	VALUES (0283398, 'Tsvetelina', 'tsvetelina@gmail.com', 08837825, 'volunteer_adopter');

INSERT INTO CLIENTS
	VALUES (2356894, 'Berna', 'berna@gmail.com', 088238734, 'volunteer_adopter');

INSERT INTO CLIENTS
	VALUES (3257215, 'Will Smith', 'willSmith@gmail.com', 088367453, 'volunteer_adopter');

INSERT INTO CLIENTS
	VALUES (6545344, 'Valentin', 'valentin@gmail.com', 0842147355, 'volunteer_adopter');

INSERT INTO CLIENTS
	VALUES (2147324, 'Johhny Depp', 'johhnyDepp@gmail.com', 0879325345, 'volunteer_adopter');



INSERT INTO PERSONNEL
	VALUES (874367,'Kaloyan',0813679999,'James Boucher 14','Sofia');

INSERT INTO PERSONNEL
	VALUES (125467,'Deniz',0813125467,'Aleksander Todorov 15','Shumen');

INSERT INTO PERSONNEL
	VALUES (879033,'Viktoriq',0800847676,'Todor Kablev 10','Varna');

INSERT INTO PERSONNEL
	VALUES (343743,'Katerina',0813343743,'Tsar Simeon Veliki','Vidin');

INSERT INTO PERSONNEL
	VALUES (209240,'Gergana',0820924099,'Aleksander Todorov 15','Shumen');

INSERT INTO PERSONNEL
	VALUES (123456,'Denitza',0811234569,'James Boucher 14','Sofia');

INSERT INTO PERSONNEL
	VALUES (234567,'Viktor',0823456799,'San Stefano','Pleven');

INSERT INTO PERSONNEL
	VALUES (345678,'Siyana',0834567899,'San Stefano','Pleven');

INSERT INTO PERSONNEL
	VALUES (456789,'Lina',0823456789,'Tsar Simeon Veliki','Vidin');

INSERT INTO PERSONNEL
	VALUES (567890,'Plamen',0823567890,'Todor Kablev 10','Varna');



INSERT INTO ANIMAL_KEEPERS
	VALUES (874367);

INSERT INTO ANIMAL_KEEPERS
	VALUES (125467);

INSERT INTO ANIMAL_KEEPERS
	VALUES (879033);

INSERT INTO ANIMAL_KEEPERS
	VALUES (343743);

INSERT INTO ANIMAL_KEEPERS
	VALUES (209240);



INSERT INTO STAFF
	VALUES (123456);

INSERT INTO STAFF
	VALUES (234567);

INSERT INTO STAFF
	VALUES (345678);

INSERT INTO STAFF
	VALUES (456789);

INSERT INTO STAFF
	VALUES (567890);



INSERT INTO ANIMALS
	VALUES (12332,'Doug','Labrador', 'Dog', 2, 'James Boucher 14', 'Sofia');

INSERT INTO ANIMALS
	VALUES (57783,'Zuzi','Persian', 'Cat', 1,'Aleksander Todorov 15', 'Shumen');

INSERT INTO ANIMALS
	VALUES (34742,'Pesho','Ara', 'Parrot', 15,'Todor Kablev 10', 'Varna');

INSERT INTO ANIMALS
	VALUES (45674,'Gosho','Angora', 'Rabbit', 3, 'Tsar Simeon Veliki', 'Vidin');

INSERT INTO ANIMALS
	VALUES (343195,'Tisho','Golden', 'Hamster', 2,'San Stefano', 'Pleven');



INSERT INTO TAKES_CARE
	VALUES (12332,209240);

INSERT INTO TAKES_CARE
	VALUES (57783,343743);

INSERT INTO TAKES_CARE
	VALUES (34742,879033);

INSERT INTO TAKES_CARE
	VALUES (45674,125467);

INSERT INTO TAKES_CARE
	VALUES (343195,874367);



INSERT INTO ADOPTS
	VALUES ('Todor Kablev 10','Varna','Pesho','11.02.2016',223443);

INSERT INTO ADOPTS
	VALUES ('Tsar Simeon Veliki','Vidin','Gosho','31.01.2022',343565);

INSERT INTO ADOPTS
	VALUES ('Aleksander Todorov 15','Shumen','Zuzi','10.05.2019',436735);

INSERT INTO ADOPTS
	VALUES ('San Stefano','Pleven','Tisho','17.11.2021',837462);

INSERT INTO ADOPTS
	VALUES ('James Boucher 14','Sofia','Doug','12.05.2017',343215);

INSERT INTO ADOPTS
	VALUES ('Tsar Simeon Veliki','Vidin','Gosho' ,'17.06.2016',837462);

INSERT INTO ADOPTS
	VALUES ('James Boucher 14','Sofia','Doug' ,'19.08.2020',223443);


	
INSERT INTO VISITS
	VALUES ('Todor Kablev 10','Varna',8895426);

INSERT INTO VISITS
	VALUES ('Tsar Simeon Veliki','Vidin',1343254);

INSERT INTO VISITS
	VALUES ('Aleksander Todorov 15','Shumen',132134);

INSERT INTO VISITS
	VALUES ('San Stefano','Pleven',765878);

INSERT INTO VISITS
	VALUES ('James Boucher 14','Sofia',213542);

INSERT INTO VISITS
	VALUES ('James Boucher 14','Sofia',837462);

INSERT INTO VISITS
	VALUES ('San Stefano','Pleven',2147324);

INSERT INTO VISITS
	VALUES ('Aleksander Todorov 15','Shumen',837462);

INSERT INTO VISITS
	VALUES ('Tsar Simeon Veliki','Vidin',436735);

INSERT INTO VISITS
	VALUES ('James Boucher 14','Sofia',223443);

INSERT INTO VISITS
	VALUES ('Todor Kablev 10','Varna',343565);

INSERT INTO VISITS
	VALUES ('Tsar Simeon Veliki','Vidin',0283398);

INSERT INTO VISITS
	VALUES ('Tsar Simeon Veliki','Vidin',2356894);

INSERT INTO VISITS
	VALUES ('San Stefano','Pleven',343215);

INSERT INTO VISITS
	VALUES ('James Boucher 14','Sofia',6545344);



INSERT INTO GIVES_FOR_ADOPTION
	VALUES ('James Boucher 14','Sofia','Pesho','27.03.2015',213542);

INSERT INTO GIVES_FOR_ADOPTION
	VALUES ('Tsar Simeon Veliki','Vidin','Gosho','15.10.2016',765878);

INSERT INTO GIVES_FOR_ADOPTION
	VALUES ('Aleksander Todorov 15','Shumen','Zuzi','14.12.2019',132134);

INSERT INTO GIVES_FOR_ADOPTION
	VALUES ('San Stefano','Pleven','Tisho','28.04.2018',1343254);

INSERT INTO GIVES_FOR_ADOPTION
	VALUES ('James Boucher 14','Sofia','Doug','28.03.2021',8895426);



INSERT INTO SERVICE
	VALUES (123456, 0283398);

INSERT INTO SERVICE
	VALUES (234567, 2356894);

INSERT INTO SERVICE
	VALUES (345678, 3257215);

INSERT INTO SERVICE
	VALUES (456789, 837462);

INSERT INTO SERVICE
	VALUES (567890, 765878);

INSERT INTO SERVICE
	VALUES (456789, 1343254);

INSERT INTO SERVICE
	VALUES (345678, 6545344);

INSERT INTO SERVICE
	VALUES (234567, 343215);

INSERT INTO SERVICE
	VALUES (567890, 213542);

INSERT INTO SERVICE
	VALUES (456789, 8895426);

INSERT INTO SERVICE
	VALUES (234567, 223443);

INSERT INTO SERVICE
	VALUES (345678, 343565);

INSERT INTO SERVICE
	VALUES (123456, 436735);

INSERT INTO SERVICE
	VALUES (567890, 2147324);

INSERT INTO SERVICE
	VALUES (234567, 132134);



------- Примери с индекси -------

CREATE INDEX IDX_ANIMALS_SPECIES ON ANIMALS(SPECIES);
CREATE INDEX IDX_ANIMALS_BREED ON ANIMALS(BREED);
CREATE INDEX IDX_PERSONNEL_SHELTER_ADDRESS ON PERSONNEL(SHELTER_ADDRESS);
CREATE INDEX IDX_PERSONNEL_TOWN_NAME ON PERSONNEL(TOWN_NAME);



------- Примери с изгледи -------

-- Следния изглед изкарва имената за всеки работник от базата данни Staff
GO
CREATE VIEW v_Names_Of_Staff_Members
AS 
SELECT NAME FROM STAFF s JOIN PERSONNEL p
ON s.PRIVATE_ID = p.PRIVATE_ID 
GO

-- Следния изглед изкарва имената за всеки работник от базата данни Animal_Keepers
GO
CREATE VIEW v_Names_Of_Animal_Keepers_Members
AS 
SELECT NAME FROM ANIMAL_KEEPERS s JOIN PERSONNEL p
ON s.PRIVATE_ID = p.PRIVATE_ID 
GO

--Следният изглед извежда имената и имейлите на клиентите, които са доброволци.
GO
CREATE VIEW v_Names_And_Emails_Of_Volunteers 
AS
	SELECT NAME, EMAIL
	FROM CLIENTS 
	WHERE TYPE_CLIENT='volunteer';
GO

--Изглед, който показва името на приюта, адреса, града, броя на животните в него
GO
CREATE VIEW v_Number_Of_Animals
AS
SELECT s.NAME, s.ADDRESS, s.TOWN_NAME, COUNT(a.ANIMAL_ID) number_of_animals
FROM Shelters s, Animals a
WHERE s.ADDRESS=a.SHELTER_ADDRESS AND s.TOWN_NAME=a.TOWN_NAME
GROUP BY s.NAME, s.ADDRESS, s.TOWN_NAME
GO

-- Изглед, който показва броя на осиновените животни от всеки клиент
GO
CREATE VIEW v_Clients_Adoptions_Count
AS
SELECT c.CLIENT_ID, c.NAME, count(ad.ANIMAL) AS "Adoptions count"
FROM CLIENTS c 
JOIN ADOPTS ad ON ad.CLIENT_ID = c.CLIENT_ID
GROUP BY c.NAME, c.CLIENT_ID;
GO

--Създайте изглед, който показва идентификационния номер и имената на персонала, както и в кой приют работят
GO
CREATE VIEW v_Shelters_Personnel
AS
SELECT p.PRIVATE_ID as PERSONNEL_ID, p.NAME as PERSONNEL_NAME, s.NAME as SHELTER_NAME
FROM PERSONNEL p JOIN SHELTERS s
ON p.SHELTER_ADDRESS=s.ADDRESS
AND p.TOWN_NAME=s.TOWN_NAME
GO



------- Примери с тригери -------

-- Тригер, който при изтриване на данни от таблицата TOWNS, при създадена TOWNS_RESERVED
-- добавя изтритото в тази таблица, с цел запазването на информацията

CREATE TABLE TOWNS_RESERVED (
    NAME VARCHAR(20) NOT NULL
);

GO
CREATE TRIGGER TRG_TOWNS_RESERVED
ON TOWNS
FOR DELETE
AS
BEGIN
	Declare @NAME VARCHAR(20)
	SELECT @NAME = NAME FROM deleted
	INSERT INTO TOWNS_RESERVED
	VALUES (@NAME)
END
GO

-- Тригер който следи при insert, броя на посетителите на даден приют да не надвишават 10 клиента

GO
CREATE TRIGGER TRG_CLIENTS_VISITS_COUNT
ON VISITS
FOR INSERT
AS
BEGIN
	Declare @addr VARCHAR(30)
	SELECT @addr = SHELTER_ADDRESS FROM inserted

	Declare @townName VARCHAR(30)
	SELECT @townName  = TOWN_NAME FROM inserted

	Declare @counter int
	SELECT @counter = (SELECT COUNT(v.CLIENT_ID) FROM VISITS v WHERE v.SHELTER_ADDRESS = @addr AND v.TOWN_NAME = @townName)

	IF ( @counter > 10 ) 
		PRINT ('Shelter limit for clients reached!')
END
GO


-- Тригер, който следи дали при добавяне на клиент в GIVES_FOR_ADOPTION, клиентското ID, което е сложено е такова на клиент,
-- които е от тип Volunteer или Volunteer_Аdopter 

GO
CREATE TRIGGER TRG_GIVES_FOR_ADOPTION_CHECK_ID
ON GIVES_FOR_ADOPTION
FOR INSERT
AS
BEGIN
	Declare @ID CHAR(10)
	SELECT @ID = CLIENT_ID FROM inserted 
	IF (@ID NOT IN (SELECT CLIENT_ID FROM CLIENTS WHERE TYPE_CLIENT LIKE 'VOLUNTEER%' OR TYPE_CLIENT LIKE 'volunteer%')) 
		PRINT ('Invalid client type ID')
END
GO



-- Тригер, който следи дали при добавяне на клиент в ADOPTS, клиентското ID, което е сложено е такова на клиент,
-- които е от тип Аdopter или Аdopter_Volunteer 

GO
CREATE TRIGGER TRG_ADOPTS_CHECK_ID
ON ADOPTS
FOR INSERT
AS
BEGIN
	Declare @ID CHAR(10)
	SELECT @ID = CLIENT_ID FROM inserted 
	IF (@ID NOT IN (SELECT CLIENT_ID FROM CLIENTS WHERE TYPE_CLIENT LIKE 'ADOPTER%' OR TYPE_CLIENT LIKE 'adopter%')) 
		PRINT ('Invalid client type ID')
END
GO

