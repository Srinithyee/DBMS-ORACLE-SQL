REM ==========================================
REM		PL/SQL-Triggers
REM		-Srinithyee S K
REM		-185001166
REM ==========================================

REM 1.The date of arrival should be always later than or on the same date of departure.

CREATE OR REPLACE TRIGGER same_later_date
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
BEGIN
	IF(:NEW.departs > :NEW.arrives) OR (:OLD.arrives<:NEW.departs) OR (:OLD.departs > :NEW.arrives) THEN
		RAISE_APPLICATION_ERROR(-20111,'VIOLATES THE ARRIVAL CRITERION');
END;
/

REM ==VIOLATING THE CONDITION,RAISING TRIGGER==
INSERT INTO fl_schedule VALUES('B6-474','23-apr-2005',1710,'22-apr-2005',2120,261.56);

DROP TRIGGER same_later_date;

REM 2.Flight number CX­7520 is scheduled only on Tuesday, Friday and Sunday.

CREATE OR REPLACE TRIGGER flightsch_day
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
DECLARE 
BEGIN
 IF NOT ( TO_CHAR(:NEW.departs,'Dy','NLS_DATE_LANGUAGE=English') IN ('Tue','Fri','Sun')
              AND :NEW.flno = 'CX7520' ) THEN  
    RAISE_APPLICATION_ERROR(-20000,'Flight number CX­7520 can be scheduled only on Tuesday, Friday and Sunday.');
 END IF;
END;
/

REM ==VIOLATING INSERT SATURDAY==
INSERT INTO fl_schedule VALUES('CX-7520','18-APR-20',1245,'18-APR-20',1850,450.25);

REM ==VIOLATING UPDATE SATURDAY==
UPDATE fl_schedule SET departs = '19-APR-2020' WHERE flno = 'CX-7520' AND departs = '10-APR-2020';

REM 3.An aircraft is assigned to a flight only if its cruising range is more than the distance of the flights’ route.

CREATE OR REPLACE TRIGGER assign_check
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
DECLARE
	cruise_range aircraft.cruisingrange%TYPE;
	rt_distance routes.distance%TYPE;
BEGIN
	SELECT air.cruisingrange INTO cruise_range 
	FROM aircraft air
	WHERE air.aid = :NEW.aid;

	SELECT rt.distance INTO rt_distance
	FROM routes rt
	WHERE rt.routeID = :NEW.rID;

	IF (rt_distance > cruise_range) THEN
		RAISE_APPLICATION_ERROR(-20001,'Violates Cruising range Requirement');
	END IF;
END;
/

REM AIRBUS:ID:3::CRUISING RANGE::7120
REM ==VIOLATING THE REQUIREMENT==
INSERT INTO routes VALUES('MQ198,'California','San Diego',8056);

INSERT INTO flights VALUES('8A-6577','MQ198',3);

DROP TRIGGER assign_check;