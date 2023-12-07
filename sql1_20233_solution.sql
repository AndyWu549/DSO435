set echo on;
set pagesize 60;
set linesize 150;
set autocommit on;

alter session set recyclebin=off;

DROP TABLE ATTENDS;
DROP TABLE DOCTOR CASCADE CONSTRAINTS;
DROP TABLE BILLS;
DROP TABLE ITEM CASCADE CONSTRAINTS;
DROP TABLE ITEM_CAT CASCADE CONSTRAINTS;
DROP TABLE ACCOMMODATION CASCADE CONSTRAINTS;
-- OPTIONALLY DISABLE THE FK CONSTRAINT OR JUST USE CASCADE CONSTRAINTS
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE PATIENT CASCADE CONSTRAINTS;


-- STEP 1

CREATE TABLE patient (
PATIENT_NO NUMBER CONSTRAINT PATIENT_PK PRIMARY KEY,
PATIENT_NAME VARCHAR2(64) CONSTRAINT PATIENT_PATIENTNAME_NULL NOT NULL,
SEX VARCHAR2(1) CONSTRAINT PATIENT_SEX_NULL NOT NULL CONSTRAINT PATIENT_SEX_CHECK CHECK (SEX IN ('M','F')),
DISCHARGE DATE,
ADMIT DATE CONSTRAINT PATIENT_ADMIT_NULL NOT NULL,
ROOM_NO VARCHAR2(5) CONSTRAINT PATIENT_ROOM_UNIQ UNIQUE,
EST_DISCHARGE DATE,
CONSTRAINT PATIENT_DATE_CHECK CHECK (DISCHARGE >= ADMIT),
CONSTRAINT PATIENT_DATE_CHECK2 CHECK (EST_DISCHARGE >= ADMIT));

CREATE TABLE ACCOMMODATION (
ACCOMM_TYPE VARCHAR2(2) CONSTRAINT ACCOMMODATION_PK PRIMARY KEY,
ACCOMMODATION VARCHAR2(30) CONSTRAINT ACCOMMODATION_ACCOM_NULL NOT NULL);

CREATE TABLE ROOM (
ROOM_NO VARCHAR2(5) CONSTRAINT ROOM_PK PRIMARY KEY,
ACCOMM VARCHAR2(2) CONSTRAINT ROOM_ACCOMM_NULL NOT NULL CONSTRAINT ROOM_ACCOM_FK REFERENCES ACCOMMODATION,
EXT_NUM VARCHAR2(6) CONSTRAINT ROOM_EXT_NUM_NULL NOT NULL, 
PATIENT_NO NUMBER CONSTRAINT ROOM_PATIENT_NO_FK REFERENCES PATIENT CONSTRAINT ROOM_PATIENT_UNIQ UNIQUE);

ALTER TABLE PATIENT
ADD CONSTRAINT PATIENT_ROOM_FK FOREIGN KEY (ROOM_NO) REFERENCES ROOM (ROOM_NO);

CREATE TABLE ITEM_CAT (
ITEM_CAT VARCHAR2(1) CONSTRAINT ITEM_CAT_PK PRIMARY KEY,
DESCRIPTION VARCHAR2(30) CONSTRAINT ITEM_CAT_DESC_NULL NOT NULL);

CREATE TABLE ITEM (
ITEM_CODE NUMBER(3) CONSTRAINT ITEM_PK PRIMARY KEY,
DESCRIPTION VARCHAR2(30) CONSTRAINT ITEM_DESC_NULL NOT NULL,
CAT CONSTRAINT ITEM_CAT_NULL NOT NULL CONSTRAINT ITEM_CAT_FK REFERENCES ITEM_CAT);

-- No good primary key candidate column(s)
CREATE TABLE BILLS (
ITEM_CODE NUMBER(3) CONSTRAINT BILLS_ITEM_CODE_NULL NOT NULL CONSTRAINT BILLS_ITEM_CODE_FK REFERENCES ITEM,
CHARGE NUMBER(6,2) CONSTRAINT BILLS_CHARGE_NULL NOT NULL CONSTRAINT BILLS_CHARGE_CHECK CHECK (CHARGE >= 0),
PATIENT_NO NUMBER(3) CONSTRAINT BILLS_PATIENT_FK REFERENCES PATIENT CONSTRAINT BILLS_PATIENT_NULL NOT NULL);

CREATE TABLE DOCTOR (
DOCTOR_ID VARCHAR2(10) CONSTRAINT DOCTOR_PK PRIMARY KEY,
DOCTOR_PHONE NUMBER(5) CONSTRAINT DOCTOR_PHONE_NULL NOT NULL,
SALARY NUMBER(7) CONSTRAINT DOCTOR_SALARY_NULL NOT NULL CONSTRAINT DOCTOR_SALARY_CHECK CHECK (SALARY >=0),
HIRE_DATE DATE CONSTRAINT DOCTOR_HIRE_DATE_NULL NOT NULL);

-- No good primary key candidate column(s)
-- Would also accept a combination of patient_no, treatment_time, doctor_id
CREATE TABLE ATTENDS (
DOCTOR_ID VARCHAR2(10) CONSTRAINT ATTENDS_DOCTOR_NULL NOT NULL CONSTRAINT ATTENDS_DOCTOR_FK REFERENCES DOCTOR,
PROCEDURE VARCHAR2(36) CONSTRAINT ATTENDS_PROCEDURE_NULL NOT NULL,
PATIENT_NO NUMBER(3) CONSTRAINT ATTENDS_PATIENT_NULL NOT NULL CONSTRAINT ATTENDS_PATIENT_FK REFERENCES PATIENT,
TREATMENT_TIME DATE CONSTRAINT ATTENDS_TREATTIME_NULL NOT NULL);

ALTER TABLE PATIENT DISABLE CONSTRAINT PATIENT_ROOM_FK;

ALTER SESSION SET NLS_DATE_FORMAT='MM-DD-YYYY';

-- STEP 2

INSERT INTO PATIENT VALUES (333, 'Chen, Kayanne', 'M', '12-13-2022','11-25-2022', '', '');
INSERT INTO PATIENT VALUES (334, 'O''Melveny, Laura', 'F', '12-10-2022','11-25-2022', '', '');
INSERT INTO PATIENT VALUES (335, 'Kim, Sarah', 'F', '','11-26-2022', '100-1', '01-28-2023');
INSERT INTO PATIENT VALUES (336, 'Clive, Hannah', 'F', '','11-26-2022', '110-1', '01-26-2023');
INSERT INTO PATIENT VALUES (337, 'Kim, Tommy', 'M', '12-15-2022','11-26-2022', '', '');
INSERT INTO PATIENT VALUES (338, 'James, Geoffrey', 'M', '01-10-2023','11-27-2022', '', '');
INSERT INTO PATIENT VALUES (339, 'Cai, Winnie', 'F', '','11-28-2022', '140-1', '11-29-2022');
INSERT INTO PATIENT VALUES (340, 'Jiao, Stella', 'F', '01-01-2023','12-21-2022', '', '');
INSERT INTO PATIENT VALUES (341, 'Brown, A.G.', 'M', '','12-25-2022', '250-1', '12-26-2022');
INSERT INTO PATIENT VALUES (342, 'Hensel, Joel Jules', 'M', '','12-25-2022', '230-1', '12-29-2022');
INSERT INTO PATIENT VALUES (343, 'Chen, Adam', 'M', '','12-26-2022', '220-2', '12-30-2022');
INSERT INTO PATIENT VALUES (344, 'Angel, Anna', 'F', '','12-27-2022', '220-1', '01-04-2023');
INSERT INTO PATIENT VALUES (345, 'Lauda, Roland N.', 'M', '12-30-2022','12-27-2022', '', '');
INSERT INTO PATIENT VALUES (346, 'Striker, Sam', 'M', '','12-28-2022', '150-1', '01-02-2023');
INSERT INTO PATIENT VALUES (347, 'Gerber, Maylane', 'F', '01-01-2023','12-31-2022', '', '');

INSERT INTO ACCOMMODATION VALUES ('DP', 'Dumpster In Alley');
INSERT INTO ACCOMMODATION VALUES ('WD', 'Ward');
INSERT INTO ACCOMMODATION VALUES ('SP', 'Semi-Private');
INSERT INTO ACCOMMODATION VALUES ('PR', 'Private');
INSERT INTO ACCOMMODATION VALUES ('HA', 'Hallway');
INSERT INTO ACCOMMODATION VALUES ('AH', 'Alley Behind Hospital');
INSERT INTO ACCOMMODATION VALUES ('SU', 'Suite');

INSERT INTO ROOM VALUES ('100-1', 'PR','2-1001', 335);
INSERT INTO ROOM VALUES ('110-1', 'PR','2-1101', 336);
INSERT INTO ROOM VALUES ('120-1', 'SP','2-1201', NULL);
INSERT INTO ROOM VALUES ('130-2', 'DP','2-1302', NULL);
INSERT INTO ROOM VALUES ('140-1', 'PR','2-1401', 339);
INSERT INTO ROOM VALUES ('150-1', 'SP','2-1501', 346);
INSERT INTO ROOM VALUES ('150-2', 'AH','2-1502', NULL);
INSERT INTO ROOM VALUES ('220-1', 'WD','2-2201', 344);
INSERT INTO ROOM VALUES ('220-2', 'WD','2-2202', 343);
INSERT INTO ROOM VALUES ('230-1', 'WD','2-2301', 342);
INSERT INTO ROOM VALUES ('240-1', 'WD','2-2401', NULL);
INSERT INTO ROOM VALUES ('250-1', 'PR','2-2501', 341);

ALTER TABLE PATIENT ENABLE CONSTRAINT PATIENT_ROOM_FK;

INSERT INTO DOCTOR VALUES ('Finlay', 17820, 360000, '05-25-1989');
INSERT INTO DOCTOR VALUES ('Hickman', 17821, 34000, '08-25-1995');
INSERT INTO DOCTOR VALUES ('Layton', 17822, 1280000, '11-25-1984');
INSERT INTO DOCTOR VALUES ('Buchannan', 17823, 225000, '03-25-1998');
INSERT INTO DOCTOR VALUES ('Butterick', 17834, 496000, '01-25-1985');
INSERT INTO DOCTOR VALUES ('Montgomery', 17835, 700000, '04-25-2023');

INSERT INTO ITEM_CAT VALUES ('E', 'Examinations');
INSERT INTO ITEM_CAT VALUES ('S', 'Surgery');
INSERT INTO ITEM_CAT VALUES ('O', 'Oncology');
INSERT INTO ITEM_CAT VALUES ('A', 'Accommodation');
INSERT INTO ITEM_CAT VALUES ('R', 'Radiology');
INSERT INTO ITEM_CAT VALUES ('N', 'Neurology');

INSERT INTO ITEM VALUES (100, 'Room - Private', 'A');
INSERT INTO ITEM VALUES (101, 'Room - Semi-private', 'A');
INSERT INTO ITEM VALUES (707, 'Tonsillectomy', 'S');
INSERT INTO ITEM VALUES (102, 'Room - Ward', 'A');
INSERT INTO ITEM VALUES (105, 'Television', 'A');
INSERT INTO ITEM VALUES (406, 'Physical Exam', 'E');
INSERT INTO ITEM VALUES (200, 'Pillow', 'A');
INSERT INTO ITEM VALUES (204, 'Chair', 'A');
INSERT INTO ITEM VALUES (313, 'Lab Tests', 'E');
INSERT INTO ITEM VALUES (350, 'Chemotherapy', 'O');
INSERT INTO ITEM VALUES (423, 'Head Transplant', 'S');
INSERT INTO ITEM VALUES (511, 'Tracheotomy', 'S');
INSERT INTO ITEM VALUES (699, 'Coronary Bypass', 'S');
INSERT INTO ITEM VALUES (208, 'Rhinoplasty', 'S');
INSERT INTO ITEM VALUES (207, 'X-Ray', 'R');

ALTER SESSION SET NLS_DATE_FORMAT = 'MM-DD-YYYY HH24:MI:SS';

INSERT INTO ATTENDS VALUES ('Finlay', 'Tonsillectomy', 333, '11-25-2022 08:14:58');
INSERT INTO ATTENDS VALUES ('Layton', 'Lobotomy', 337, '11-26-2022 12:32:24');
INSERT INTO ATTENDS VALUES ('Butterick', 'Appendectomy', 336, '11-26-2022 23:48:47');
INSERT INTO ATTENDS VALUES ('Finlay', 'Observation', 335, '11-27-2022 10:48:48');
INSERT INTO ATTENDS VALUES ('Finlay', 'Chemotherapy', 335, '11-27-2022 14:20:00');
INSERT INTO ATTENDS VALUES ('Buchannan', 'X-Ray', 338, '11-28-2022 11:12:20');
INSERT INTO ATTENDS VALUES ('Butterick', 'Physical Exam', 339, '11-29-2022 09:30:19');
INSERT INTO ATTENDS VALUES ('Montgomery', 'X-Ray', 341, '12-25-2022 13:23:54');
INSERT INTO ATTENDS VALUES ('Butterick', 'X-Ray', 344, '12-27-2022 14:28:37');
INSERT INTO ATTENDS VALUES ('Finlay', 'X-Ray', 345, '12-27-2022 15:20:48');
INSERT INTO ATTENDS VALUES ('Butterick', 'Observation', 345, '12-28-2022 09:40:39');
INSERT INTO ATTENDS VALUES ('Butterick', 'Minor Surgery', 345, '12-29-2022 10:28:54');

INSERT INTO BILLS VALUES (100, 400, 346);
INSERT INTO BILLS VALUES (101, 450, 338);
INSERT INTO BILLS VALUES (105, 414.5, 334);
INSERT INTO BILLS VALUES (207, 255, 338);
INSERT INTO BILLS VALUES (313, 339.25, 336);
INSERT INTO BILLS VALUES (406, 458.86, 339);
INSERT INTO BILLS VALUES (511, 852, 337);
INSERT INTO BILLS VALUES (100, 350, 337);
INSERT INTO BILLS VALUES (207, 720, 344);
INSERT INTO BILLS VALUES (208, 6209.8, 335);
INSERT INTO BILLS VALUES (423, 1975, 339);
INSERT INTO BILLS VALUES (707, 1265.2, 333);
INSERT INTO BILLS VALUES (105, 341.5, 346);
INSERT INTO BILLS VALUES (200, 190.5, 342);
INSERT INTO BILLS VALUES (207, 245, 341);
INSERT INTO BILLS VALUES (207, 195, 345);
INSERT INTO BILLS VALUES (102, 1325.54, 341);
INSERT INTO BILLS VALUES (200, 263.35, 343);
INSERT INTO BILLS VALUES (105, 412.12, 340);
INSERT INTO BILLS VALUES (100, 490.32, 341);

COLUMN CHARGE FORMAT '$9,999.99'; 
-- I THINK THIS WORKS ON SQL+, if not need to do TO_CHAR() ON QUERIES

COLUMN SALARY FORMAT '$9,999,999'; 
-- I THINK THIS WORKS ON SQL+, if not need to do TO_CHAR() ON QUERIES

-- STEP 3

SELECT * FROM CAT;

-- STEP 4

DESC PATIENT;
DESC ROOM;
DESC DOCTOR;
DESC ITEM;
DESC ATTENDS;
DESC BILLS;
DESC ITEM_CAT;
DESC ACCOMMODATION;

-- STEP 5 

ALTER SESSION SET NLS_DATE_FORMAT = 'MM-DD-YY';
SELECT * FROM DOCTOR;
SELECT * FROM PATIENT;
SELECT * FROM ITEM;
SELECT * FROM ACCOMMODATION;
ALTER SESSION SET NLS_DATE_FORMAT = 'MM-DD-YYYY HH24:MI:SS';
SELECT * FROM ATTENDS;
SELECT * FROM BILLS;
SELECT * FROM ROOM;
SELECT * FROM ITEM_CAT;

-- STEP 6

/* 1)	List the patient name, charge amount and the description of the items for 
all patients who have been discharged. */

SELECT 
    patient_name, 
    charge, 
    description
FROM 
    patient, 
    bills, 
    item
WHERE 
    patient.patient_no = bills.patient_no AND 
    bills.item_code = item.item_code AND 
    patient.discharge IS NOT NULL;


/* 2)	List all the patient names for all patients who were discharged in DECEMBER 
of 2022 and stayed for at least 5 days. */

ALTER SESSION SET NLS_DATE_FORMAT = 'MM-DD-YY';

SELECT 
    patient_name, 
    (discharge-admit) days_spent
FROM 
    patient
WHERE 
    discharge LIKE '12-%22' AND 
    discharge - admit >=  5;


/* 3)  List the patient name(s), and their total sum of charges for the patient(s) who have been billed the most times.
*/

SELECT
    patient.patient_name,
    TO_CHAR(SUM(charge), '$9,999.99') charge
    -- Optional to_char formatting
FROM
    bills,
    patient
WHERE
    bills.patient_no = patient.patient_no
GROUP BY
    patient.patient_name
HAVING
    COUNT (bills.patient_no) = (
        SELECT
            MAX (COUNT(bills.patient_no))
        FROM
            bills
        GROUP BY
            bills.patient_no);


/* 4)	List the doctor and his/her salary for the doctor who has worked the longest at the hospital. */

SELECT 
    doctor_id, 
    salary
FROM 
    doctor
WHERE 
    hire_date IN (SELECT MIN(hire_date) FROM doctor);

/* 5)	List the patients who have been charged for x-ray (you must use "X-ray" in the query). */

SELECT 
    patient.patient_name
FROM 
    patient, 
    bills, 
    item
WHERE 
    item.description = 'X-Ray' AND 
    patient.patient_no = bills.patient_no AND 
    bills.item_code = item.item_code;


/* 6)	List the patient name and the sum of their charges for every patient who 
has been attended by the doctor at phone 17834 (you need to use the doctor table). */

SELECT 
    patient_name, 
    SUM(charge) charge
FROM 
    patient, 
    bills
WHERE 
    patient.patient_no = bills.patient_no AND  
    patient.patient_no IN (
        SELECT 
            patient_no
        FROM 
            attends, 
            doctor
        WHERE 
            attends.doctor_id=doctor.doctor_id AND  
            doctor_phone= 17834)
GROUP BY 
    patient_name;


/* 7)	List the names of patients who were treated by both Dr. Butterick and by Dr. Finlay. */

SELECT 
    patient_name 
FROM 
    patient
WHERE 
    patient_no IN (
        SELECT 
            patient_no
        FROM 
            attends
        WHERE 
            doctor_id = 'Butterick'
        INTERSECT
        SELECT 
            patient_no
        FROM 
            attends
        WHERE 
            doctor_id = 'Finlay');

/* 8)  List the doctor, salary, ratio of salary to number of treatments ratio for the doctors who have done at least one treatment, ordered by highest to lowest ratio */
SELECT
    doctor.doctor_id,
    doctor.salary,
    doctor.salary / COUNT(attends.doctor_id) salary_treatment_ratio
FROM
    doctor,
    attends
WHERE
    doctor.doctor_id = attends.doctor_id
GROUP BY
    doctor.doctor_id,
    doctor.salary
ORDER BY
    doctor.salary / COUNT(attends.doctor_id) DESC;


/* 9)	List the patient names, procedures and the doctors who have performed procedures on patients that cannot be billed (i.e., procedures for which there are no item_codes). */

SELECT 
    patient_name, 
    procedure, 
    doctor_id
FROM 
    patient, 
    attends
WHERE 
    procedure IN (
        SELECT 
            procedure 
        FROM 
            attends 
        MINUS 
        SELECT 
            description 
        FROM 
            item) AND 
    patient.patient_no = attends.patient_no;



/* 10)  List the name of the patient, the procedure administered, and the amount of time that transpired, for the patient(s) who received a treatment (was treated) least promptly after being admitted to the hospital (show in fraction of day, in hours or in minutes). */

SELECT
    patient_name,
    procedure,
    ROUND(treatment_time - admit, 2) days_transpired
FROM
    patient,
    attends
WHERE
    patient.patient_no = attends.patient_no AND
    treatment_time - admit = (
        SELECT
            MAX(treatment_time - admit)
        FROM
            patient,
            attends
        WHERE
            patient.patient_no = attends.patient_no AND
            treatment_time - admit IN (
                SELECT
                    MIN(treatment_time - admit)
                FROM
                    patient,
                    attends
                WHERE
                    patient.patient_no = attends.patient_no
                GROUP BY
                    patient.patient_no));


/* 11)	 List the name, admit date and total charges for Brown, Kim, and Gerber (output must include all of their names). */

SELECT 
    patient_name, 
    admit, 
    SUM(charge) charge
FROM 
    patient, 
    bills
WHERE 
    (UPPER(patient_name) LIKE 'BROWN%' 
    OR UPPER(patient_name) LIKE 'KIM%' 
    OR UPPER(patient_name) LIKE 'GERBER%') AND 
    patient.patient_no = bills.patient_no (+)
GROUP BY 
    patient_name, 
    admit;
-- OPTIONALLY USE NVL() AND TO_CHAR TO SHOW A 0 FOR NULL, BUT NOT REQUIRED

/* 12) 
List the accommodation type (code), accommodation (description), and the average total of charges billed to the patients who are currently residing in room/beds of that accommodation type.
*/

SELECT
    accomm_type,
    accommodation,
    TRUNC(AVG(sumcharge),2) sum_charge
FROM
    accommodation,
    (SELECT 
        accomm,
        bills.patient_no,
        sum(charge) sumcharge
    FROM
        room,
        bills
    WHERE
        room.patient_no = bills.patient_no
    GROUP BY
        accomm,
        bills.patient_no)
WHERE
    accomm = accommodation.accomm_type
GROUP BY 
    accomm_type,
    accommodation;

/* 
<EOF>
*/


