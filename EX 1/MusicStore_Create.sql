drop table SungBy;
drop table Artist;
drop table Song;
drop table Album;
drop table Studio;
drop table Musician;

rem creating musician

CREATE TABLE Musician 
(
	Mus_ID NUMBER(3) CONSTRAINT id_pk PRIMARY KEY,
	Mus_name VARCHAR2(25),
	Mus_birthplace VARCHAR2(25) 
);

rem creating Studio

CREATE TABLE Studio
(
	Studio_name VARCHAR2(25) CONSTRAINT std_name_pk PRIMARY KEY,
	Studio_addr VARCHAR2(50) ,
	Studio_Phone NUMBER(10)
);

rem creating Album

rem question 7 done in line 6
rem question 8 done in line 5 
CREATE TABLE Album
(
	album_name VARCHAR2(25),
	album_ID NUMBER(3) CONSTRAINT a_id_pk PRIMARY KEY,
	year_of_release NUMBER(4) CONSTRAINT Album_release_check CHECK ( year_of_release > 1945),
	no_of_tracks NUMBER(3) CONSTRAINT no_of_tracks_null NOT NULL,
	stud_name VARCHAR2(25) CONSTRAINT stud_fk REFERENCES Studio(Studio_name) ,
	album_genre VARCHAR2(20) CONSTRAINT al_genre_restriction CHECK (album_genre in ('CAR','DIV','MOV','POP')),
	musician_id NUMBER(3) CONSTRAINT mus_id_fk REFERENCES Musician(Mus_ID)  
);

rem creating Song

rem question 8 done in line 9

CREATE TABLE Song
(
	alb_ID NUMBER(3) CONSTRAINT a_id_fk REFERENCES Album(album_ID) ,
	track_no NUMBER(3) ,
	Song_name VARCHAR2(25),
	Song_len NUMBER(3) ,
	Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK(Song_genre in ('PHI','REL','LOV','DEV','PAT')),
	CONSTRAINT song_alid_track_pk PRIMARY KEY (alb_ID,track_no),
	CONSTRAINT song_len_check_7 CHECK(Song_genre !='PAT' OR Song_len >= 7 ) 
);

rem creating Artist

rem question 6 done in line 4

CREATE TABLE Artist
(
	artist_ID NUMBER(3) CONSTRAINT art_id_pk PRIMARY KEY,
	artist_name VARCHAR2(25) CONSTRAINT art_name_null NOT NULL
);

rem creating SungBy

CREATE TABLE SungBy
(
	al_ID NUMBER(3) ,
	ar_ID NUMBER(3) CONSTRAINT ar_id_fk REFERENCES Artist(artist_ID),
	track NUMBER(3) ,
	recording_date DATE,
	CONSTRAINT al_id__track_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ,
	CONSTRAINT Sung_by_pk PRIMARY KEY (al_ID,ar_ID,track)
);






rem Populating Tables

INSERT INTO Musician VALUES
(
	123,
	'Rocky',
	'Delhi'
);

INSERT INTO Musician VALUES
(
	124,
	'BeeBom',
	'Sweden'
);
INSERT INTO Musician VALUES
(
	125,
	'Sri charan',
	'Chennai'
);

SELECT * FROM Musician; 

INSERT INTO Studio VALUES
(
	'Kraken',
	'Beijing',
	9923514674
);

INSERT INTO Studio VALUES
(
	'Moana',
	'Goa',
	9563443774
);
INSERT INTO Studio VALUES
(
	'Param',
	'Mumbai',
	9821476544
);

SELECT * FROM Studio;

INSERT INTO Album VALUES
(
	'Karoke',
	456,
	1992,
	6,
	'Param',
	'POP',
	124
);

INSERT INTO Album VALUES
(
	'Gaka',
	457,
	1982,
	18,
	'Moana',
	'DIV',
	125
);

INSERT INTO Album VALUES
(
	'Mojang',
	458,
	2012,
	3,
	'Kraken',
	'MOV',
	123
);

SELECT * FROM Album;

INSERT INTO Song VALUES
(
	456,
	897,
	'Despacito',
	4,
	'LOV'
);

rem ****************************************

rem violation of song length 7 for Pat constraint

rem ****************************************

INSERT INTO Song VALUES
(
	458,
	898,
	'Rubble',
	2,
	'PAT'
);

INSERT INTO Song VALUES
(
	458,
	898,
	'Rubble',
	12,
	'PAT'
);

INSERT INTO Song VALUES
(
	457,
	896,
	'Magico Remix',
	7,
	'DEV'
);


INSERT INTO Song VALUES
(
	457,
	898,
	'Magico',
	7,
	'DEV'
);

SELECT * FROM Song;

INSERT INTO Artist VALUES
(
	101,
	'Margarita'
);

INSERT INTO Artist VALUES
(
	102,
	'Justin Beaber'
);

INSERT INTO Artist VALUES
(
	103,
	'Jane Wills'
);

SELECT * FROM Artist;

INSERT INTO SungBy VALUES
(
	456,
	102,
	897,
	'12-JUN-00'
);

INSERT INTO SungBy VALUES
(
	458,
	101,
	898,
	'19-MAY-83'
);

INSERT INTO SungBy VALUES
(
	457,
	103,
	896,
	'29-DEC-91'
);

INSERT INTO SungBy VALUES
(
	457,
	102,
	896,
	'12-DEC-96'
);

SELECT * FROM SungBy;

rem ******************************************

rem Displaying All tables

rem ******************************************

SELECT * FROM SungBy;
SELECT * FROM Artist;
SELECT * FROM Song;
SELECT * FROM Album;
SELECT * FROM Studio;
SELECT * FROM Musician;