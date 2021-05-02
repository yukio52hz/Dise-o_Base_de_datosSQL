CREATE DATABASE bd_gyms
GO
USE bd_gyms
GO
CREATE TABLE gym(
   code_gym INT NOT NULL IDENTITY(1,1), --codigo de gimnasio
   gym_name VARCHAR(50) NOT NULL UNIQUE, --nombre del gimnasio
   phone VARCHAR(18) NOT NULL UNIQUE, --telefono
   contact_general VARCHAR(70) NOT NULL,--contacto general

   CONSTRAINT PK_CODE_GYM PRIMARY KEY CLUSTERED (code_gym),--llave primaria
)
CREATE TABLE campus(
 id_campus INT IDENTITY(1,1) NOT NULL ,--id de la sede
 campus_name VARCHAR(50) NOT NULL UNIQUE,-- nombre sede
 email VARCHAR(40) NOT NULL UNIQUE,
 canton VARCHAR(40) NOT NULL,
 province VARCHAR(40) NOT NULL,--provincia

 id_gym INT NOT NULL ,--llave foranea

 CONSTRAINT PK_ID_CAMPUS PRIMARY KEY CLUSTERED (id_campus),--llave primaria
 CONSTRAINT FK_CODE_GYM FOREIGN KEY (id_gym) REFERENCES gym(code_gym),--llave foranea
)
CREATE TABLE phones_campus(
   phone_number VARCHAR(18) NOT NULL UNIQUE,
   campus_belong  INT NOT NULL,
   
   CONSTRAINT FK_ID_CAMPUS_BELONG FOREIGN KEY (campus_belong) REFERENCES campus(id_campus),--llave foranea
)
CREATE TABLE employee(
   indentification_card VARCHAR(15) NOT NULL UNIQUE,--cedula
   employee_name VARCHAR(40) NOT NULL,--nombre del empleado
   email VARCHAR(40) NOT NULL UNIQUE,
   salary MONEY NOT NULL DEFAULT 0,--salario
   date_birt DATE NOT NULL,--fecha de nacimiento

   campus INT NOT NULL, --llave foranea

   CONSTRAINT PK_IDENTIFICATION PRIMARY KEY CLUSTERED (indentification_card),--llave primaria
   CONSTRAINT FK_ID_CAMPUS FOREIGN KEY (campus) REFERENCES campus(id_campus),--llave foranea
)
CREATE TABLE administrator(
   id_employee VARCHAR(10) NOT NULL ,--llave primaria
   position VARCHAR(30) NOT NULL,
   id_admin VARCHAR(15) NOT NULL,--llave foranea cedula
   
   CONSTRAINT PK_IDENTIFICATION_ADMIN PRIMARY KEY CLUSTERED (id_employee),
   CONSTRAINT FK_ID_ADMIN FOREIGN KEY (id_admin) REFERENCES  employee(indentification_card),--llave foranea
)
CREATE TABLE instructor(
   id_employee VARCHAR(10) NOT NULL ,--llave primaria 
   id_instruc VARCHAR(15) NOT NULL,--llave foranea 
   CONSTRAINT PK_IDENTIFICATION_INSTRUC PRIMARY KEY CLUSTERED (id_employee),
   CONSTRAINT FK_ID_INTRUCTOR FOREIGN KEY (id_instruc) REFERENCES  employee(indentification_card),--llave foranea
)
CREATE TABLE certifications(
   id_instructor VARCHAR(10) NOT NULL, --llave foranea
   name_certifications VARCHAR(30) NOT NULL,--nombre de la certificacion
   descript_certification VARCHAR(100) NOT NULL,--descripcion del certificado
   CONSTRAINT FK_INTRUCTOR FOREIGN KEY (id_instructor) REFERENCES instructor(id_employee),
)
CREATE TABLE client(--tabla de clientes
  id_card_client VARCHAR(15) NOT NULL UNIQUE,--identificacion
  name_client VARCHAR(40) NOT NULL,--nombre
  email VARCHAR(40) NOT NULL UNIQUE,
  sex CHAR(1) NOT NULL,--sexo F o M
  height DECIMAL(3,2) NOT NULL DEFAULT 0,--estatura  
  risk CHAR(2) NOT NULL,--si es de riesgo si no
  date_birt DATE NOT NULL,--fecha de nacimiento 
 

  affilieted_instructor VARCHAR(10) NOT NULL,--llave foranea intructor

   CONSTRAINT PK_CLIENT_IDENTIFICATION PRIMARY KEY CLUSTERED (id_card_client),--llave primaria
   CONSTRAINT FK_INTRUCTOR_ASSOCIATED FOREIGN KEY (affilieted_instructor) REFERENCES instructor(id_employee),--llave foranea
)
CREATE TABLE muscle_group(--tabla de los ejercicios por zona
  id_zone_moscular INT NOT NULL IDENTITY(1,1),
  worked_area VARCHAR(30) NOT NULL UNIQUE,

  CONSTRAINT PK_MUSCLE PRIMARY KEY CLUSTERED (id_zone_moscular),--llave primaria
)
CREATE TABLE exercises(--tabla de ejercicios
  id_exercise INT NOT NULL IDENTITY(1,1),
  name_exercise VARCHAR(40) NOT NULL UNIQUE,

  exercised_area INT NOT NULL,--llave foranea
  
  CONSTRAINT PK_ID_EXERCISE PRIMARY KEY CLUSTERED (id_exercise),
  CONSTRAINT FK_EXERCISES FOREIGN KEY (exercised_area) REFERENCES muscle_group(id_zone_moscular),--llave foranea
)
CREATE TABLE grind(--rutina
  id_grind INT NOT NULL IDENTITY(1,1),
  create_date DATE NOT NULL,--fecha de creacion
  expiration_date DATE NOT NULL,--fecha de expiracion
  customer VARCHAR(15) NOT NULL,--el dueño de la rutina
  training_exercises INT NOT NULL,--los ejercicios

  CONSTRAINT PK_ID_GRIND PRIMARY KEY CLUSTERED (id_grind),--llave primaria
  CONSTRAINT FK_CLIENT FOREIGN KEY (customer) REFERENCES client(id_card_client),--llave foranea
  CONSTRAINT FK_THE_EXERCISES FOREIGN KEY (training_exercises) REFERENCES exercises(id_exercise),--lave foranea
)
CREATE TABLE measuring(--medidas
  id_measuring INT NOT NULL IDENTITY(1,1),
  weight_client INT NOT NULL DEFAULT 0,--peso cliente
  fat_percentage DECIMAL(4,2) NOT NULL DEFAULT 0,--porcentaje grasa
  muscle_percentage DECIMAL(4,2) NOT NULL DEFAULT 0,--porcentaje musculo
  viseral_fat_percentage DECIMAL(4,2) NOT NULL DEFAULT 0,--grasa viceral
  metabolic_ege INT NOT NULL DEFAULT 0,--edad metabolica

  CONSTRAINT PK_ID_MEASURING PRIMARY KEY CLUSTERED (id_measuring),
)
/*CREATE TABLE report(
  id_report INT IDENTITY(1,1) NOT NULL,
  subgestive_water_intake INT
  subgestive_protein_intake DECIMAL(4,2)
  ideal_measures INT
  physical_activity VARCHAR(30)

  measure INT NOT NULL,--llave foranea de medidas

  CONSTRAINT PK_ID_MEASURING PRIMARY KEY CLUSTERED (id_report),
  CONSTRAINT FK_MEASURING FOREIGN KEY (measure) REFERENCES measuring(id_measuring),
)*/
CREATE TABLE appointment(--cita
  date_appointment DATE NOT NULL,
  time_appointment TIME NOT NULL,

  fk_cr_client VARCHAR(15) NOT NULL,
  fk_cr_instructor VARCHAR(10) NOT NULL,
  fk_id_measuring INT NOT NULL,
  CONSTRAINT FK_CLIENT_DATE FOREIGN KEY (fk_cr_client) REFERENCES client(id_card_client),
  CONSTRAINT FK_INSTRUCTOR_DATE FOREIGN KEY (fk_cr_instructor) REFERENCES instructor(id_employee),
  CONSTRAINT FK_MEASURING_DATE FOREIGN KEY (fk_id_measuring) REFERENCES measuring(id_measuring),
  
)
