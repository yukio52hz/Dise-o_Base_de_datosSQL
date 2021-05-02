--Gimnasio
INSERT INTO gym(gym_name,phone,contact_general)
VALUES('Las Americas Gym','88419907','Hatillo centro carretera de circunvalación 1101 San José')
INSERT INTO gym(gym_name,phone,contact_general)
VALUES('Dumbell Gym','70890055','Escazu centro')
INSERT INTO gym(gym_name,phone,contact_general)
VALUES('Golds Gym','80900089','Estados Unidos')
--sede
INSERT INTO campus(campus_name,email,canton,province,id_gym)
VALUES('Gym las Americas Hatillos','gymAmericas@gmail.com','Hatillo','San José',1)
INSERT INTO campus(campus_name,email,canton,province,id_gym)
VALUES('Gym Silverman','silverman@gmail.com','Sabana','San José',2)
INSERT INTO campus(campus_name,email,canton,province,id_gym)
VALUES('Golds Gym CR Moravia','goldsGymCr@gmail.com','Moravia','San José',3)
INSERT INTO campus(campus_name,email,canton,province,id_gym)
VALUES('Golds Gym CR Guayabos','goldsGymGyCr@gmail.com','Guayabos','San José',3)
--sede numeros 
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('70701254',1)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('89705600',1)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('60691232',2)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('88903310',2)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('22353660',3)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('22359660',3)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('22710915',4)
INSERT INTO phones_campus(phone_number,campus_belong)
VALUES('87870054',4)
--empleado
INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('015544249','Anna Victoria Cmpbell','jesinta_franklin@gmail.com',456000,'1988-02-13',1)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('055674890','Calos Campos Jimenez','calosj_j@gmail.com',500000,'1993-09-24',1)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('090034678','Lee Jun fan','iKnowlikeWater@gmail.com',500000,'1987-11-27',1)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('010033144','Vadym Calavera','vadymBuffacademy@gmail.com',500000,'1987-08-27',1)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('040567880','Machio Naruzo','muscleMachio@gmail.com',505000,'2000-08-27',2)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('012305060','Lelouch Lamperouge','iamZero@gmail.com',600000,'1999-12-05',2)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('025507070','Yoshikage Kira','hands@gmail.com',800000,'1990-01-30',3)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('045587879','Takamura Mamoru','box@gmail.com',800000,'1990-06-07',3)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('079034569','Kensei Ma','masterMarter@gmail.com',800000,'1990-01-30',3)

INSERT INTO employee(indentification_card,employee_name,email,salary,date_birt,campus)
VALUES('015679089','Suzaku Kururugi','kamen@gmail.com',610000,'2000-05-10',4)

--administrador
INSERT INTO administrator(id_employee,position,id_admin)
VALUES('admin-01','Contador','055674890')
INSERT INTO administrator(id_employee,position,id_admin)
VALUES('admin-02','Administrador','012305060')
INSERT INTO administrator(id_employee,position,id_admin)
VALUES('admin-03','Contador','015679089')
--entrenadores
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-01','015544249')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-02','090034678')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-03','010033144')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-04','040567880')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-05','025507070')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-06','045587879')
INSERT INTO instructor(id_employee,id_instruc)
VALUES('instruc-07','079034569')
--certificaciones
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-01','Entrenamiento Funcional')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-02','Maestro de Wing Chun')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-02','Maestro de Jeet kune do')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-03','Street workout')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-04','Entrenador Personal')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-05','Fitnes Coach')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-05','Cross Training')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-06','Entrenador de Pesas y Musculación')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-06','ZUMBA FITNESS')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-06','Entrenador Personal especializado en Mujeres “Sistema Freestyle”')
INSERT INTO certifications(id_instructor,name_certifications)
VALUES('instruc-07','Entrenador Personal especializado en Mujeres “Sistema Freestyle”')
--clientes
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('060439045','Farid Gamboa Matarrita','iamfarid1997@gmail.com','M',1.75,'no','1996-01-12','Media','instruc-02')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('064923730','Sakura Hibiki','hibikiss@gmail.com','F',1.60,'no','2003-06-22','Normal','instruc-04')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('012456780','Amara Maple','lanarhoades@gmail.com','F',1.60,'no','1996-07-06','Normal','instruc-05')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('034587901','Lexi Luna Johnson','lexiluna@gmail.com','F',1.75,'no','1989-03-14','Normal','instruc-05')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('062376098','Rae Lil Black','raelilblack@gmail.com','F',1.45,'no','1996-04-17','Media','instruc-06')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('027766890','Antonella Alonso','sirena69@gmail.com','F',1.57,'no','1990-05-09','Normal','instruc-07')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('037690899','Skylar Vox','vox3312@gmail.com','F',1.57,'no','2000-01-09','Media','instruc-06')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('050789068','Ronald Dean Colema','ronnieColeman@gmail.com','M',1.80,'no','1996-04-07','Dura','instruc-06')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('030356098','Arnold Alois Schwarzenegger','terminator667@gmail.com','M',1.88,'no','1990-06-30','Dura','instruc-06')
INSERT INTO client(id_card_client,name_client,email,sex,height,risk,date_birt,level_physical_activity,affilieted_instructor)
VALUES('040550988','Dwayne Douglas Johnson','therock@gmail.com','M',1.93,'no','1972-04-02','Dura','instruc-06')
--clientes_campus
INSERT INTO client_campus(campus,client)
VALUES(1,'060439045')
INSERT INTO client_campus(campus,client)
VALUES(2,'064923730')
INSERT INTO client_campus(campus,client)
VALUES(3,'012456780')
INSERT INTO client_campus(campus,client)
VALUES(3,'034587901')
INSERT INTO client_campus(campus,client)
VALUES(3,'062376098')
INSERT INTO client_campus(campus,client)
VALUES(3,'027766890')
INSERT INTO client_campus(campus,client)
VALUES(3,'050789068')
INSERT INTO client_campus(campus,client)
VALUES(3,'030356098')
INSERT INTO client_campus(campus,client)
VALUES(3,'040550988')
INSERT INTO client_campus(campus,client)
VALUES(3,'037690899')
--muscle group
INSERT INTO muscle_group(worked_area)
VALUES('Pecho')
INSERT INTO muscle_group(worked_area)
VALUES('Espalda')
INSERT INTO muscle_group(worked_area)
VALUES('Piernas')
INSERT INTO muscle_group(worked_area)
VALUES('Biceps')
INSERT INTO muscle_group(worked_area)
VALUES('Triceps')
INSERT INTO muscle_group(worked_area)
VALUES('Antebrazos')
INSERT INTO muscle_group(worked_area)
VALUES('Abdominales')
INSERT INTO muscle_group(worked_area)
VALUES('Isquiotibiales')
INSERT INTO muscle_group(worked_area)
VALUES('Caudriceps')
INSERT INTO muscle_group(worked_area)
VALUES('Glúteos')

--ejercicios
--pecho
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Press de banca',1)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Lagartijas',1)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Press de banca inclinado',1)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Aleteo con cable',1)
--espalda
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Dominadas agarre supino',2)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Dominadas agarre prono',2)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Remo con pesa',2)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Muscle up',2)
--pierna
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Sentadilla',3)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Extención de rodilla',3)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Sentadilla con salto',3)
INSERT INTO exercises(name_exercise,exercised_area)
VALUES('Peso muerto',3)
--cita
--1
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2019-05-20','3:00')
--2
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-12','2:00')
--3
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-01','8:00')
--4
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-01','1:00')
--5
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-11-26','1:00')
--6
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-11-28','2:00')
--7
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-10','8:00')
--8
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-05','10:00')
--9
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2021-01-07','7:00')
--10
INSERT INTO appointment(date_appointment,time_appointment)
VALUES('2020-12-01','6:00')
--citas_instructor
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-03',1)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-04',2)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-07',3)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-07',4)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-01',5)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-07',6)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-07',7)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-06',8)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-05',9)
INSERT INTO date_instructor(fk_cr_instructor,fk_appointment)
VALUES('instruc-07',10)

--citas_clientes
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('060439045',1)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('064923730',2)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('050789068',3)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('027766890',4)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('060439045',5)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('062376098',6)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('034587901',7)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('030356098',8)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('062376098',9)
INSERT INTO date_client(fk_cr_client,fk_appointment)
VALUES('040550988',10)

--medicion
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(55,10,17.4,8,18,17,1)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(56.1,18,20.5,10,22,14,2)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(135,5,34,5,15,14,3)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(45,15,10,10,19,20,4)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(60,10,25,3,18,18,5)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(44,10,18,10,19,18,6)
INSERT INTO measuring(weight_client,fat_percentage,muscle_percentage,viseral_fat_percentage,metabolic_age,wrist_size,appointment)
VALUES(114,12,12,6,25,20,10)