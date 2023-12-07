drop table People CASCADE CONSTRAINTS;
drop table Gender CASCADE CONSTRAINTS;
drop table Species CASCADE CONSTRAINTS;
drop table Pet_Breed CASCADE CONSTRAINTS;
drop table Pet_size CASCADE CONSTRAINTS;
drop table contact CASCADE CONSTRAINTS;
drop table Dependent CASCADE CONSTRAINTS;
drop table spouse CASCADE CONSTRAINTS;
drop table Income_Amount CASCADE CONSTRAINTS;
drop table location CASCADE CONSTRAINTS;
drop table school CASCADE CONSTRAINTS;
drop table District CASCADE CONSTRAINTS;
drop table Religion CASCADE CONSTRAINTS;
Drop table Sleeping_Area CASCADE CONSTRAINTS;
Drop table Sleeping_Area_Other CASCADE CONSTRAINTS;
Drop table Living_Status CASCADE CONSTRAINTS;
Drop table Applicant CASCADE CONSTRAINTS;
Drop Table Pets CASCADE CONSTRAINTS;
Drop Table Income_Source CASCADE CONSTRAINTS;
Drop Table Applicant_Income_Relation CASCADE CONSTRAINTS;
Drop Table Gov_Assistance CASCADE CONSTRAINTS;
Drop Table Applicant_Gov_Relation CASCADE CONSTRAINTS;
Drop Table Coalition_Member CASCADE CONSTRAINTS;
Drop Table Intake_Form CASCADE CONSTRAINTS;
Drop Table Dependent_Intake CASCADE CONSTRAINTS;
drop table Contact_Intake CASCADE CONSTRAINTS;
drop Table preIntake CASCADE CONSTRAINTS;
drop table referral CASCADE CONSTRAINTS;
drop table referral_applicant CASCADE CONSTRAINTS;

create table pet_size(
Pet_Size_id number(1) PRIMARY KEY,
P_Size Varchar2(1) not null);

Create Table Species(
Species_ID number(5) Primary KEY,
Species_Name Varchar2(30) not null);

create table Pet_Breed(
Breed_Id number(4) Primary Key,
Breed_Name Varchar2(30) not null,
Species_ID number(5) constraint Species_NN not null
                     constraint Species_FK References Species);

Create table Gender(
Gender_ID number(4) primary Key,
Gender varchar2(10) not null);

Create Table People(
Person_Id number(6) Primary Key,
First_Name Varchar2(25) not null,
Middle_Name Varchar2(25),
Last_name Varchar2(25) not null,
Applicant Varchar2(1),
Spouse Varchar2(1),
Dependent Varchar2(1),
Contact Varchar2(1),
Gender_ID number(4) Constraint Gender_NN not null
                    Constraint Gender_FK references Gender);

Create Table Contact(
Person_Id number(6) Primary Key Constraint Person_Contact_FK references People,
Relation Varchar2(15) not null,
Phone_num Varchar(20) not null);

Create Table Dependent(
Person_ID number(6) Primary Key Constraint Person_Dependent_FK references People,
DOB Date not null,
Help varchar2(1));

Create Table Spouse(
Person_ID number(6) Primary Key Constraint Person_Spouse_FK references People,
DOB date);

Create Table District(
District_ID number(10) Primary Key,
District_Name varchar2(100) not null);

Create Table School (
School_ID number(10) Primary Key,
School_name Varchar2(100) not null,
District_ID number(10) constraint School_NN not null
                       constraint School_FK references District);

Create Table Location(
Location_ID Number(10) Primary Key,
Location_name Varchar2(20) Not null);

Create Table Income_Amount(
BracketID number(5) Primary Key,
Income_Bracket varchar2(25) not null);

Create Table Religion(
Religion_ID number(10) Primary Key,
Relgion_Name Varchar2(15) not null);

create table Sleeping_Area(
Area_ID number(10) Primary Key,
Area_Name varchar2(25) not null);

Create Table Sleeping_Area_Other(
Area_Other_ID Number(10) Primary Key,
Area_name Varchar(35) not null);

Create Table Living_Status(
Living_Status_ID number(5) Primary Key,
Shelter Varchar2(15) not null);

Create Table Income_Source(
Income_ID number(10) Primary Key,
Income_Desc Varchar2(25) not null);

Create Table Applicant(
Person_ID number(6) Primary Key Constraint Person_Applicant_FK references People,
Phone_Type varchar2(100) not null,
Phone_Num Varchar2(100) not null,
Email Varchar2(100),
DOB date not null,
Bank_Account Varchar2(1) not null,
Pic_ID Varchar2(1) not null,
SNN number(9),
Homeless_duration Varchar2(25),
Income_ID number(10) constraint Applicant_Income_Fk references Income_Source,
BracketID number(5) constraint Bracket_NN Not null constraint Bracket_FK references Income_Amount,
Religion_ID number(10) constraint Religion_FK references Religion,
Area_ID number(10) constraint Area_FK references Sleeping_Area,
Area_Other_ID number(10) constraint Area_Other_FK references sleeping_area_other,
Living_Status_ID number(5) constraint Living_Applicant_FK references Living_Status);

Create Table Pets(
Pet_ID number(6) Primary Key,
Pet_Name Varchar(20) not null,
Person_ID number(6) constraint Pets_Applicant_FK references Applicant,
Pet_Size_ID number(1) constraint Pets_Size_FK references Pet_Size,
Breed_ID number(4) constraint Pet_Breed_FK references Pet_Breed);


Create Table Applicant_Income_Relation(
Person_ID number(6) constraint Person_Income_FK references Applicant,
Income_ID Number(10) constraint Income_Income_FK references Income_source,
Constraint Applicant_Income_Relation_PK primary Key (Person_ID, Income_ID));

Create Table Gov_Assistance(
Assistance_ID number(5) Primary Key,
Gov_Assistance_Type varchar2(40) not null);

Create Table Applicant_Gov_Relation(
Assistance_ID number(5) constraint Gov_FK references Gov_Assistance,
Person_ID number(6) constraint Gov_Person_FK references Applicant,
Constraint Applicant_Gov_Relation_Pk Primary Key(Assistance_ID,Person_ID));

Create Table Coalition_Member(
Memeber_ID number(10) Primary Key,
First_Name varchar2(25) not null,
Middle_Name varchar2(25),
Last_name Varchar2(25) not null);

Create Table Intake_Form(
Form_id number(15) Primary Key,
Datetime Date not null,
Homeless_Start_Date Date not null,
Lit_Homeless_Y_N varchar2(1) not null,
Relocate_Y_N varchar2(1) not null,
Vehicle_Y_N varchar2(1) not null,
Agency_Permission_Y_N varchar2(1) not null,
Trigger_of_Homeless varchar2(100) not null,
Instability varchar2(100) not null,
Health_Insurance_Y_N varchar2(1) not null,
Last_Year_school number(4),
Credit_Y_N varchar2(1) not null,
Resume_Y_N varchar2(1) not null,
Criminal_Record_Y_N varchar2(1) not null,
Veteran_Status_Y_N varchar2(1) not null,
Internet_Y_N varchar2(1) not null,
Child_Y_N varchar2(1) not null,
Housing_assistance varchar2(1),
Location_ID number(10) constraint Location_Intake_NN not null constraint Intake_Location references location,
Member_ID number(10) constraint Coalition_intake_FK references Coalition_Member,
School_ID number(10) constraint School_Intake_NN not null constraint School_Intake_FK references School,
Spouse_Person_ID number(6) constraint Spouse_Intake_FK references Spouse,
Applicant_Person_ID number(6) constraint Applicant_Person_NN not null constraint Applicant_Intake_FK references Applicant);

Create Table PreIntake(
PreIntake_ID number(6) primary key,
Applicant_ID number(6) Constraint PreIntake_person_NN not null Constraint PreIntake_Person_FK references Applicant,
Spouse_ID number(6) Constraint PreIntake_Spouse references Spouse,
Location_ID number(10) Constraint PreIntake_Location_NN not null constraint PreIntake_Location_FK references Location,
preIntake_Date Date not null);

Create table Dependent_Intake(
Person_ID number(6) constraint Dependent_Pretake_D_FK references Dependent,
PreIntake_ID number(6) constraint Dependent_Pretake_form_FK references preIntake,
constraint Dependent_Intake_PK Primary Key(Person_ID,PreIntake_ID));

Create table Contact_Intake(
Person_ID number(6) constraint Contact_Intake_C_FK references Contact,
Form_ID number(15) constraint Contact_Intake_Form_FK references Intake_Form,
constraint Contact_Intake_PK primary key(Person_ID, Form_id));

Create Table Referral (
Referral_num number(5) primary key,
First_Name varchar2(30) not null,
Middle_Name varchar2(30),
Last_Name varchar2(30) not null);

Create table Referral_Applicant(
Person_ID number(6) constraint Referral_Applicant_Fk references Applicant,
Referral_num number(5) constraint Referral_Referral_Fk references Referral,
constraint Referral_Applicant_Pk primary key( Person_ID, Referral_num));

CREATE INDEX Contact_Intake_C_FK ON Contact_Intake (Person_ID);
CREATE INDEX Contact_Intake_Form_FK ON Contact_Intake(Form_ID);
CREATE INDEX Dependent_Intake_D_FK ON Dependent_Intake(Person_ID);
CREATE INDEX Dependent_Intake_Form_FK ON Dependent_Intake(PreIntake_ID);
CREATE INDEX PET_NAME ON PETS(PET_NAME);
CREATE INDEX Pet_Applicant_FK ON PETS(Person_ID);
CREATE INDEX Pet_Size_FK ON PETS (Pet_Size_ID);
CREATE INDEX Pet_Breed_FK ON PETS (Breed_ID); 
CREATE INDEX People_First_Name ON PEOPLE(First_Name);
CREATE INDEX people_middle_name ON People(Middle_Name);
CREATE INDEX people_Last_name ON PEOPLE(LAST_NAME);
CREATE INDEX people_Applicant ON PEOPLE(Applicant);
CREATE INDEX People_spouse ON People(Spouse);
CREATE INDEX People_Dependent ON People(Dependent);
CREATE INDEX People_Contact ON People(Contact);
CREATE INDEX People_Gender_FK ON People(Gender_ID);
CREATE INDEX Spouse_DOB ON Spouse(DOB);
CREATE INDEX Contact_Relation_Atr ON Contact(Relation);
CREATE INDEX Contact_Phone_num ON Contact(Phone_num);
CREATE INDEX Dependent_DOB ON Dependent(DOB);
CREATE INDEX Dependent_help ON Dependent(Help);
CREATE INDEX Applicant_Phone_Type ON Applicant(Phone_Type);
CREATE INDEX Applicant_Phone_Num ON Applicant(Phone_Num);
CREATE INDEX Applicant_Email ON Applicant(Email);
CREATE INDEX Applicant_DOB ON Applicant(DOB);
CREATE INDEX Applicant_Bank_Account ON Applicant(Bank_Account);
CREATE INDEX Applicant_Pic_ID ON Applicant(Pic_ID);
CREATE INDEX Applicant_BrackID_FK ON Applicant(BracketID);
CREATE INDEX Applicant_Religion_ID_FK ON Applicant(Religion_ID);
CREATE INDEX Applicant_Area_ID_FK ON Applicant(Area_ID);
CREATE INDEX Applicant_Area_Other_ID_FK ON Applicant(Area_Other_ID);
CREATE INDEX Applicant_Living_Status_ID_FK ON Applicant(Living_Status_ID);
CREATE INDEX Intake_Form_Datetime ON Intake_Form(Datetime);
CREATE INDEX Intake_Homeless_Start_Date ON Intake_Form(Homeless_Start_Date);
CREATE INDEX Intake_Lit_Homeless ON Intake_Form(Lit_Homeless_Y_N);
CREATE INDEX Intake_Relocate ON Intake_Form(Relocate_Y_N);
CREATE INDEX Intake_Vehicle On Intake_Form(Vehicle_Y_N);
CREATE INDEX Intake_Agency_P ON Intake_Form(Agency_Permission_Y_N);
CREATE INDEX Intake_Trigger ON Intake_Form(Trigger_of_HomeLess);
CREATE INDEX Intake_Instability ON Intake_Form(Instability);
CREATE INDEX Intake_Health_Insurance ON Intake_Form(Health_Insurance_Y_N);
CREATE INDEX Intake_Last_School_Year ON Intake_Form(Last_Year_School);
CREATE INDEX Intake_Credit ON Intake_Form(Credit_Y_N);
CREATE INDEX Intake_Resume ON Intake_Form(Resume_Y_N);
CREATE INDEX Intake_Criminal_Record On Intake_Form(Criminal_Record_Y_N);
CREATE INDEX Intake_Veteran_Status ON Intake_Form(Veteran_Status_Y_N);
CREATE INDEX Intake_Internet ON Intake_Form(Internet_Y_N);
CREATE INDEX Intake_Child ON Intake_Form(Child_Y_N);
CREATE INDEX Intake_Member_FK ON Intake_Form(Member_ID);
CREATE INDEX Intake_Location_FK ON Intake_Form(Location_ID);
CREATE INDEX Intake_School_FK ON Intake_Form(School_ID);
CREATE INDEX Intake_Spouse_FK On Intake_Form(Spouse_Person_ID);
CREATE INDEX Intake_Applicant_FK ON Intake_Form(Applicant_person_ID);
CREATE INDEX preIntake_date On PreIntake(preIntake_Date);
CREATE INDEX Referal_R ON Referral_Applicant(Person_ID);
CREATE INDEX Referal_Person ON Referral_Applicant(Referral_Num);
/* insert data + sql query */

Alter session set NLS_Date_format = 'mm-dd-yyyy';

Insert into pet_size values(1, 'L');
Insert into pet_size values(2,'M');
Insert into pet_size values(3,'S');

Insert into Species values(1, 'Canis Lupus Familiaris');
Insert into Species values(2,'Felis');

Insert into Pet_Breed values(1,'Golden Retriver',1);
Insert into Pet_Breed values(2,'Siamese cat', 2);
Insert into Pet_Breed values(3,'Chartreux',2);

Insert into Gender values(1,'Male');
Insert into Gender Values (2, 'Female');

Insert into People values( 1,'Andy',Null,'Wu','Y','N','N','N',1);
Insert into people values( 2,'Lily',Null,'Ta','Y','N','N','N',2);
Insert into people values(3,'Ryanna',Null,'Lui','Y','N','N','N',2);
Insert into people values(4, 'Boa',Null,'Hancock','N','Y','N','N',2);
Insert into people values(5, 'Portgas','D','Ace', 'N','N','N','Y',1);
Insert into people values(6, 'Eustass',Null,'Kid','N','N','Y','N',1);
Insert into people values(7, 'Denny',Null,'Gray','Y','N','N','N',1);

Insert into Contact values(5,'Brother','(152)-632-1792');

Insert into Dependent values (6,'01-10-2010' ,'Y');

Insert into Spouse values (4, '09-02-1998');

Insert into District values(1, 'San Bernardino City Unified School District');
Insert into District Values(2,'Private School');

Insert into School Values (1, 'San Bernardino Elementry School',1);
Insert into school Values (2, 'San Bernardino High School',1);
Insert into school Values (3, 'University of Southern California',2);

Insert into location values(1, 'Los Angeles');
Insert into location values(2, 'San Berardino');
Insert into location values(3,'Riverside');

Insert into Income_Amount values (1,'0-500');
Insert into Income_Amount values (2,'501-1500');
Insert into Income_Amount values(3, '1001-2000');

Insert into Religion values (1,'Christianity');
Insert into Religion values (2,'Buddhism');

Insert into Sleeping_Area values(1, 'Park');
Insert into Sleeping_Area values(2,'Public Restroom');
Insert into Sleeping_Area values(3, 'Street');

Insert into Sleeping_Area_other values(1, 'Friends House');

Insert into Living_status values(1, 'Park bench');
Insert into Living_status values(2,'Bridge');

Insert into Income_source values(1, 'Selling Candy');
Insert into Income_source values(2, 'Ice Cream Vendor');
Insert into Income_source values(3, 'Babysitter');

Insert into Applicant values(1,'Mobile','(321)331-4491','changhao@usc.edu','11-05-2000','Y','Y',null,'4 months',2,1,null,1,null,1);
Insert into Applicant values(2,'Mobile','(213)740-2311','LilyTa007@Gamil.com','10-21-2001','N','Y',333444222,'3 months',1,2,1,2,null,2);
Insert into Applicant values(3,'Land Line','(213)841-3422','RyannaLui444@gmail.com','06-22-2002','Y','N',null,'4 months',3,3,2,null,1,2);
Insert into Applicant values(7,'Mobile','(213)349-5172','DennyGray@gmail.com','03-12-1988','Y','N',null,'4 months',3,3,2,null,1,2);

Insert into Pets values(1,'Oreo',1,3,3);
Insert into Pets values(2,'Cookie',1,3,3);
Insert into Pets values(3,'Milkshake',2,1,1);
Insert into Pets values(4,'Snow',3,2,2);
Insert into Pets values(5,'Owive',2,3,3);


Insert into Applicant_income_relation values(1,2);
Insert into Applicant_income_relation values(2,1);
Insert into Applicant_income_relation values(3,3);

Insert into Gov_assistance values(1,'Food Stamp');
Insert into Gov_assistance values(2,'Healthcare');
Insert into Gov_assistance values(3,'Subsidies');

Insert into Applicant_gov_Relation values(1,1);
Insert into Applicant_gov_relation values(1,2);
Insert into Applicant_gov_relation values(2,3);
Insert into Applicant_gov_relation values(2,2);
Insert into Applicant_gov_relation values(3,1);

Insert into Coalition_member values(1,'Kathy',Null,'Kim');
Insert into Coalition_member values(2,'Nico',Null,'Robin');

Insert into Intake_form values(1, '12-06-2023', '08-22-2023','Y','Y','Y','N','Unemployeement','No Job','Y','2022','Y','Y','N','N','Y','N','Y',1,2,1,4,1);
Insert into Intake_form Values(2, '10-15-2023','09-03-2023','Y','N','N','Y','Disability','Can not find a job','N','2023','N','Y','N','N','N','N','Y',2,1,3,null,2);
Insert into Intake_form Values(3, '11-20-2023','09-03-2023','Y','N','N','Y','Disability','Not enough government assistance','N','2023','N','Y','N','N','N','N','Y',2,1,3,null,2);
Insert into Intake_form Values(4, '9-17-2023','08-03-2023','N','Y','N','N', 'Unemployeement','Recession', 'Y','2021','Y','Y','N','N','Y','Y','Y',3,2,3,null,3);
Insert into Intake_form Values(5, '12-07-2023','08-03-2023','N','Y','N','N', 'Jobless','Unable to have a income', 'Y','2021','Y','Y','N','N','Y','Y','Y',3,2,3,null,4);

Insert into Dependent_Intake values(6,4);
Insert into Dependent_Intake values(6,5);

Insert into Contact_Intake values(5,1);

Insert into PreIntake values (1,1,4,1,'12-06-2023');
Insert into PreIntake values(2,2,null,2,'10-15-2023');
Insert into PreIntake values(3,2,null,2,'11-20-2023');
Insert into PreIntake values(4,3,null,3,'9-17-2023');
Insert into PreIntake values(5,3,null,3,'12-07-2023');

Insert into Referral values(1, 'Martha',Null,'Cuban');
Insert into Referral values(2,'Bob',Null,'Wills');

Insert into Referral_Applicant values(3,1);
Insert into Referral_Applicant values(2,1);
Insert into Referral_Applicant values(1,2);
Insert into Referral_Applicant values(2,2);

select * from applicant;
select * from person;
select * from income_source;


/* 1) searches for all applicant whose job is not babysitters */
Select First_Name, Last_Name, Income_Desc,Income_Bracket
from People p,Applicant a,Income_Amount IA,Income_source S
where p.person_Id = a.person_ID
and IA.BracketID = a.BracketID
and s.Income_ID = a.Income_ID
And s.income_ID NOT IN (select income_id
from income_source
where income_id = 3);

/* 2) shows applicants and the number of large pets that they have */
select * from pets;
select * from applicant;
select * from pet_size;

select First_Name,Last_Name,count(pets.pet_size_id) as number_of_pets
from people, applicant, pets, pet_size
where people.person_id = applicant.person_id
and pets.person_id = applicant.person_id
and pets.pet_size_ID = pet_size.pet_size_id
and p_size IN (select P_Size
from pets
where P_size like 'L')
group by First_Name, Last_Name;

/* 3) person who has been homeless the longest*/
select * from intake_form;
select First_Name, Last_Name,max(DateTime - homeless_start_date) as days_Homeless
from people, applicant, intake_Form
where people.person_id = applicant.person_id
and intake_form.applicant_Person_id = applicant.person_id
and DateTime-Homeless_Start_date in (select max(datetime-homeless_start_date) from intake_form)
group by First_Name, Last_Name;

/* 4) People who do not have government assistance */

select distinct applicant.person_id
from applicant
minus
select Distinct person_id
from applicant_gov_relation;

select First_name,last_name
from people, applicant
where applicant.person_id in (select distinct applicant.person_id
from applicant
minus
select Distinct person_id
from applicant_gov_relation)
And people.person_id = applicant.person_id;

/* 5) seperate applicant based on gender */

Select Gender, count(applicant.person_id)
from people, applicant, gender
where people.person_id = applicant.person_id
and Gender.gender_id = people.gender_id
group by gender;

/* count the gender of all people */

Select Gender, count(people.person_id)
from people, gender
where Gender.gender_id = people.gender_id
group by gender;

/* 6) show applicant that have spouse*/

select First_Name, Last_Name
from people, applicant, spouse