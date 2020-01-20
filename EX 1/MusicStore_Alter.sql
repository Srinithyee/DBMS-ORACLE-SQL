
rem question 10 :It is necessary to represent the gender of an artist in the table.

DESC Artist

ALTER TABLE Artist
ADD (gender char(1));

DESC Artist

rem *********************************************************

rem Question 10 new entry with gender

rem *********************************************************

INSERT INTO Artist VALUES
(
	104,
	'Jane Wills',
	'M'
);

SELECT * FROM Artist;

rem Question 11 :The first few words of the lyrics constitute the song name. The song name do
rem              not accommodate some of the words (in lyrics).

DESC Song

ALTER TABLE Song
MODIFY (Song_name VARCHAR2(70));

DESC Song

rem *********************************************************

rem Question 11 new Entry with longer Song name width

rem *********************************************************

INSERT INTO Song VALUES
(
	456,
	896,
	'Vinnai Thaandi Varuvaaiya By ilayaraja',
	4,
	'REL'
);


SELECT * FROM Song;

rem Question 12 :The phone number of each studio should be different.

DESC Studio

ALTER TABLE Studio
ADD CONSTRAINT ph_un
UNIQUE (Studio_Phone);

DESC Studio

rem *********************************************************

rem Question 12 new Entry Violated constraint Phone number

rem *********************************************************

INSERT INTO Studio VALUES
(
	'ken',
	'Bing',
	9923514674
);

SELECT * FROM Studio;

rem Question 13 :An artist who sings a song for a particular track of an album can not be recorded
rem              without the record_date.

DESC SungBy

ALTER TABLE SungBy
MODIFY (recording_date DATE CONSTRAINT rdate_null NOT NULL);

DESC SungBy

rem *********************************************************

rem Question 13 new entry violated constraint Date null

rem *********************************************************

INSERT INTO SungBy VALUES
(
	457,
	101,
	896,
	null
);

SELECT * FROM SungBy;

rem question 14 : It was decided to include the genre NAT for nature songs

ALTER TABLE Song
DROP CONSTRAINT song_genre_restriction;

ALTER TABLE Song
MODIFY (Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK (Song_genre in ('PHI','REL','LOV','DEV','PAT','NAT')) );




rem *********************************************************

rem Question 14 new entry new genre added NAT

rem *********************************************************

INSERT INTO Song VALUES
(
	456,
	899,
	'Hindu siddhate',
	3,
	'NAT'
);

SELECT * FROM Song;

rem question 15 : Due to typoerror,
rem               there may be a possibility of false information. Hence while
rem  		  deleting the song information, make sure that all the corresponding information are
rem 		  also deleted.

rem ********************************************
rem Before altering
rem ********************************************

SELECT * FROM Song;


SELECT * FROM SungBy;

rem **********************************************************

rem deleting a tuple

rem **********************************************************
DELETE FROM Song WHERE Song_name='Despacito';


SELECT * FROM Song;


SELECT * FROM SungBy;

rem *******************************************
rem altering table
rem *******************************************

ALTER TABLE SungBy
DROP CONSTRAINT al_id__track_fk;

ALTER TABLE SungBy
ADD CONSTRAINT al_id__track_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ON DELETE CASCADE;

rem *******************************************
rem after altering
rem *******************************************

SELECT * FROM Song;


SELECT * FROM SungBy;

rem **********************************************************

rem deleting a tuple

rem **********************************************************
DELETE FROM Song WHERE Song_name='Despacito';


SELECT * FROM Song;


SELECT * FROM SungBy;