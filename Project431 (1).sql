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

create table pet_size(
Pet_Size_id number(1) PRIMARY KEY,
Pet_Size Varchar2(1) not null);

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
Phone_num Varchar(10) not null);

Create Table Dependent(
Person_ID number(6) Primary Key Constraint Person_Dependent_FK references People,
DOB Date not null,
Help varchar2(1));

Create Table Spouse(
Person_ID number(6) Primary Key Constraint Person_Spouse_FK references People,
DOB date);

Create Table District(
District_ID number(10) Primary Key,
District_Name varchar2(20) not null);

Create Table School (
School_ID number(10) Primary Key,
School_name Varchar2(30) not null,
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

Create Table Applicant(
Person_ID number(6) Primary Key Constraint Person_Applicant_FK references People,
Phone_Type varchar2(10),
Phone_Num Varchar2(10),
Email Varchar2(30),
DOB date,
Bank_Account Varchar2(1),
Pic_ID Varchar2(1),
Pet_Number number(3),
BracketID number(5) constraint Bracket_NN Not null constraint Bracket_FK references Income_Amount,
Religion_ID number(10) constraint Religion_FK references Religion,
Area_ID number(10) constraint Applicant_Area_NN not null constraint Area_FK references Sleeping_Area,
Area_Other_ID number(10) constraint Area_Other_FK references sleeping_area_other,
Living_Status_ID number(5) constraint Living_Applicant_FK references Living_Status);

Create Table Pets(
Pet_ID number(6) Primary Key,
Pet_Name Varchar(20) not null,
Person_ID number(6) constraint Pets_Applicant_FK references Applicant,
Pet_Size_ID number(1) constraint Pets_Size_FK references Pet_Size,
Breed_ID number(4) constraint Pet_Breed_FK references Pet_Breed);

Create Table Income_Source(
Income_ID number(10) Primary Key,
Income_Desc Varchar2(25) not null);

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
Homeless_Duration varchar2(25) not null,
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
Location_ID number(10) constraint Location_Intake_NN not null constraint Intake_Location references location,
Member_ID number(10) constraint Coalition_intake_FK references Coalition_Member,
School_ID number(10) constraint School_Intake_NN not null constraint School_Intake_FK references School,
Spouse_Person_ID number(6) constraint Spouse_Intake_FK references Spouse,
Applicant_Person_ID number(6) constraint Applicant_Person_NN not null constraint Applicant_Intake_FK references Applicant);

Create table Dependent_Intake(
Person_ID number(6) constraint Dependent_Intake_D_FK references Dependent,
Form_ID number(15) constraint Dependent_Intake_form_FK references Intake_form,
constraint Dependent_Intake_PK Primary Key(Person_ID,Form_ID));

Create table Contact_Intake(
Person_ID number(6) constraint Contact_Intake_C_FK references Contact,
Form_ID number(15) constraint Contact_Intake_Form_FK references Intake_Form,
constraint Contact_Intake_PK primary key(Person_ID, Form_id));

Create Table PreIntake(
Person_ID number(6) Constraint PreIntake_Person_FK references Applicant,
Location_ID number(10) constraint PreIntake_Location_FK references Location,
preIntake_Date Date not null);

CREATE INDEX Contact_Intake_C_FK ON Contact_Intake (Person_ID);
CREATE INDEX Contact_Intake_Form_FK ON Contact_Intake(Form_ID);
CREATE INDEX Dependent_Intake_D_FK ON Dependent_Intake(Person_ID);
CREATE INDEX Dependent_Intake_Form_FK ON Dependent_Intake(Form_ID);
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
CREATE INDEX Applicant_Pet_Number ON Applicant(Pet_Number);
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
/* insert data + sql query */