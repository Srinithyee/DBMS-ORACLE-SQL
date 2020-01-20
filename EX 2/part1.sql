drop table Classes;
rem *************************************
rem Creating table :Classes
rem *************************************

CREATE TABLE Classes
(
	Class VARCHAR2(20) CONSTRAINT class_pk PRIMARY KEY,
	Type CHAR(2) CONSTRAINT type_check CHECK ( Type IN ('bb','bc')), 
	Country VARCHAR2(25),
	NumGuns Number(3),
	Bore Number(4,2),
	displacement Number(6)
);

rem *************************************
rem 1. Add first two tuples from the above sample data. List the columns explicitly in the INSERT 
rem clause. (No ordering of columns)
rem *************************************

INSERT INTO Classes(Class,Country,Type,Bore,NumGuns,Displacement)
VALUES ('Bismark','Germany','bb',14,8,32000);

INSERT INTO Classes(Class,Country,Type,Bore,NumGuns,Displacement)
VALUES ('Lowa','USA','bb',16,9,46000);

rem *************************************
rem 2. Populate the relation with the remaining set of tuples. This time, do not list the columns in 
rem the INSERT clause.
rem *************************************

INSERT INTO Classes 
VALUES('Kongo','bc','Japan',8,15,46000);

INSERT INTO Classes 
VALUES('North Carolina','bb','USA',9,16,37000);

INSERT INTO Classes 
VALUES('Revenge','bb','Gt.Britain',8,15,29000);

INSERT INTO Classes 
VALUES('Renown','bc','Gt.Britain',6,15,32000);

rem *************************************
rem 3. Display the populated relation
rem *************************************

SELECT * FROM Classes;

rem *************************************
rem 4. Mark an intermediate point here in this transaction.
rem *************************************

SAVEPOINT s1;

rem *************************************
rem 5. Change the displacement of Bismark to 34000.
rem *************************************

UPDATE Classes SET displacement=34000 WHERE Class='Bismark';

rem *************************************
rem 6. For the battleships having at least 9 number of guns or the ships with at least 15 inch bore, 
rem increase the displacement by 10%. Verify your changes to the table.
rem *************************************

UPDATE Classes SET displacement=110*displacement/100 WHERE NumGuns>8 AND Bore>=15;

rem *************************************
rem 7. Delete Kongo class of ship from Classes table.
rem *************************************

DELETE FROM Classes WHERE Class='Kongo';

rem *************************************
rem 8. Display your changes to the table.
rem *************************************

SELECT * FROM Classes;

rem *************************************
rem 9. Discard the recent updates to the relation without discarding the earlier INSERT operation(s).
rem *************************************

ROLLBACK TO s1;

rem *************************************
rem 10. Commit the changes.
rem *************************************

COMMIT;

 