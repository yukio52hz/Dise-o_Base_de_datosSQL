--imc
create function fn_calculate_imc(@height DECIMAL(3,2),@weight TINYINT )
returns DECIMAL(4,2)
as
begin
  declare @operation DECIMAL(4,2)
  set @operation = @weight /POWER(@height,2)

return @operation
end
--clasificacion
create function fn_classification_imc (@imc decimal(4,2))
returns varchar(30)
as
begin
declare @classification varchar(30)
set @classification= case 
   --WHEN (@imc <= 18.50) THEN 'Bajo Peso'
	WHEN (@imc <= 16.00) THEN 'Bajo peso'
	WHEN (@imc > 16.00) and (@imc <= 16.99) THEN 'Delgadez severa'
	WHEN (@imc >= 17.00) and (@imc <= 18.49) THEN 'Delgadez leve'
	WHEN (@imc >= 18.5) and (@imc <= 24.99) THEN 'Normal'
	--WHEN (@imc >= 25.00) THEN 'Sobrepeso'
	WHEN (@imc > 25) and (@imc <= 29.99) THEN 'Sobrepeso'
	--WHEN (@imc >= 30.00) THEN 'Obesidad'
	WHEN (@imc >= 30.00) and (@imc <= 34.99) THEN 'Obesidad leve'
	WHEN (@imc >= 35.00) and (@imc <= 39.99) THEN 'Obesidad media'
	WHEN (@imc >=  40.00) THEN 'Obesidad mórbidad'
  END
return @classification
end

--padecimientos 
create function fn_ailments_imc (@clasification varchar(20))
returns varchar(200)
as
begin
declare @ailmens varchar(200)

set @ailmens= case 
	WHEN (@clasification = 'Bajo peso') THEN 'Postración, Atenia, Adinamia, Enfermedades degenerativas y peligro de muerte'
	WHEN (@clasification = 'Delgadez severa') THEN 'Anorexia, bulimia, osteoporosis y quema de músculos para obtener energía'
	WHEN (@clasification = 'Delgadez leve')  THEN 'trastornos digestivos, debilidad, fatiga crónica, estrés, ansiedad y difusión hormonal'
	WHEN (@clasification =  'Normal') THEN 'Buen nivel de energía, vitalidad y buena condición física'
	WHEN (@clasification = 'Sobrepeso')  THEN 'Fatiga, enfermedades digestivas, problemas cardíacos, mala circulación en las piernas y varices.'
	WHEN (@clasification = 'Obesidad leve') THEN 'Diabetes, hipertensión, enfermedades cardiovasculares, problemas en las articulaciones, columna de la rodilla, cálculos biliares'
	WHEN (@clasification = 'Obesidad media')  THEN 'Diabetes, cáncer, arginina mamaria, infartos, tromboflebitis, aterosclerosis, embolias, alteraciones hormonales'
	WHEN (@clasification = 'Obesidad morvidad') THEN 'Falta de aire,somnolencia,trombosis pulmonar,ulceras varicosas,cancer de protata,reflujo esofagico,descriminacion social,laboral y sexual'
  END
return  @ailmens
end
--funcion de calcular edad
create function fn_age (@dateBirt date)
returns tinyint
as
begin 
   declare @curren_date date
   set @curren_date = (select CONVERT (date, GETDATE()))
   declare @age tinyint
   set @age = datediff(year,@dateBirt,@curren_date)
   if datepart(MONTH,@curren_date) < DATEPART(MONTH,@dateBirt)
      set @age= @age - 1
   else 
     if DATEPART(MONTH,@curren_date) = DATEPART(month,@dateBirt)
	 if DATEPART(day,@curren_date) < DATEPART(day,@dateBirt)
	    set @age = @age -1
return @age
end

--tr edad

create TRIGGER tr_age ON  client
AFTER INSERT,UPDATE
as
BEGIN TRY
  BEGIN TRANSACTION
   declare @date date
   declare @id_card varchar(15)

   select @id_card = ins.id_card_client from inserted as ins
   select @date = ins.date_birt from inserted as ins

   UPDATE client
   set age = ([dbo].[fn_age](@date))
   where id_card_client = @id_card
   
 COMMIT TRANSACTION
END TRY
  BEGIN CATCH
    DECLARE @error varchar(max)
    SELECT @error = ERROR_MESSAGE()
    print @error
    ROLLBACK TRANSACTION
END CATCH 

-- funcion de vasos de agua
create function fn_glasses_water(@weight TINYINT)
returns TINYINT
as
begin
 declare @drink TINYINT
 set @drink = @weight / 7

return @drink
end

--funcion da la proteina xd xdxddddd
CREATE FUNCTION fn_cant_protein (@id int)
returns smallint
as
begin
  declare @calculation smallint
  declare @weight tinyint
  declare @sex char(1)
  declare @physical_activity varchar(10)

  set @sex =( select cl.sex
	  from appointment as app
	  join date_client as dc on dc.fk_appointment = app.id_appointment
	  join client as cl on  cl. id_card_client =  dc.fk_cr_client
	  join measuring as m on m.id_measuring = app.id_appointment
	  where m.id_measuring = @id)
  
  set @weight = (select m.weight_client
	  from appointment as app
	  join date_client as dc on dc.fk_appointment = app.id_appointment
	  join client as cl on  cl. id_card_client =  dc.fk_cr_client
	  join measuring as m on m.id_measuring = app.id_appointment
	  where m.id_measuring = @id)

 set @physical_activity =(select cl.level_physical_activity
	  from appointment as app
	  join date_client as dc on dc.fk_appointment = app.id_appointment
	  join client as cl on  cl. id_card_client =  dc.fk_cr_client
	  join measuring as m on m.id_measuring = app.id_appointment
	  where m.id_measuring = @id)

	  if(@physical_activity = 'Normal')
	      if (@sex = 'F')
            set @calculation =  @weight * 0.8
          else
            set @calculation = @weight * 0.8
	  if(@physical_activity = 'Media')
	      if (@sex = 'F')
            set @calculation =  @weight * 1.6
          else
            set @calculation = @weight * 1.7
	 if(@physical_activity = 'Dura')
	      if (@sex = 'F')
            set @calculation = @weight * 1.8
          else
            set @calculation = @weight * 2.5
return @calculation
end
--funcion de medidas ideales
--funcion de contextura
CREATE FUNCTION fn_body_texture (@sex char(1),@wrist_size decimal(3,1),@height decimal(3,2))
returns varchar(10)
AS
BEGIN
  declare @clasification varchar(10)
 IF(@sex = 'F')
    if(@height < 1.58)
     set @clasification = case 
	 WHEN (@wrist_size < 13.9) THEN 'Pequeña'
	 WHEN (@wrist_size >= 13.9) and (@wrist_size < 14.6) THEN 'Mediana'
	 WHEN (@wrist_size > 14.6)  THEN 'Grande'
     END
  else if (@height >= 1.58) and (@height < 1.67)
    set @clasification = case 
	 WHEN (@wrist_size < 15.2) THEN 'Pequeña'
	 WHEN (@wrist_size >= 15.2) and (@wrist_size < 15.8) THEN 'Mediana'
	 WHEN (@wrist_size > 15.8)  THEN 'Grande'
     END
  else if (@height >= 1.67)
    set @clasification = case 
	 WHEN (@wrist_size < 15.8) THEN 'Pequeña'
	 WHEN (@wrist_size >= 15.8) and (@wrist_size < 16.5) THEN 'Mediana'
	 WHEN (@wrist_size > 16.5)  THEN 'Grande'
     END
IF (@sex = 'M') and (@height > 1.67)
     set @clasification = case 
	 WHEN (@wrist_size > 13.9 ) and (@wrist_size < 16.5) THEN 'Pequeña'
	 WHEN (@wrist_size >= 16.5) and (@wrist_size < 19) THEN 'Mediana'
	 WHEN (@wrist_size >= 19)  THEN 'Grande'
     END
RETURN @clasification
END
select [dbo].[fn_body_texture]('M',16,1.75)
--tr para decir que tipo de contextura tiene el men
CREATE TRIGGER tr_body_texture ON  measuring
AFTER INSERT,UPDATE
as
BEGIN TRY
  BEGIN TRANSACTION
   declare @id int
   declare @wrist_size decimal(3,1)
   declare @id_client varchar(15)
   declare @sex char(1)
   declare @height decimal(3,2)

   select @id = ins.id_measuring from inserted as ins
   select @wrist_size = ins.wrist_size from inserted as ins

   set @id_client = (select dc.fk_cr_client from appointment as app
                     join date_client as dc on dc.fk_appointment = app.id_appointment
                     join measuring as m on m.id_measuring = app.id_appointment
                     where  dc.fk_appointment = @id)

   set @sex = (select sex from client where id_card_client = @id_client)

   set @height = (select height from client where id_card_client = @id_client)

   UPDATE client
   set body_texture = ([dbo].[fn_body_texture](@sex,@wrist_size,@height))
   where id_card_client = @id_client
   
 COMMIT TRANSACTION
END TRY
  BEGIN CATCH
    DECLARE @error varchar(max)
    SELECT @error = ERROR_MESSAGE()
    print @error
    ROLLBACK TRANSACTION
END CATCH 
--funcion de porcentaje de musculo
CREATE FUNCTION muscle_percentage_ideal (@height decimal(3,2),@sex char(1))
returns varchar(20)
AS
BEGIN
  declare @muscle_ideal varchar(30)
  if(@sex = 'F')
  set @muscle_ideal = case 
	WHEN (@height < 1.30) THEN '29% - 35%'
	WHEN (@height >= 1.30) and (@height < 1.60) THEN '33% - 37.5%'
	WHEN (@height >= 1.60)  THEN '36.5% - 42,5%'
    ELSE 'XD'
  END
  ELSE 
  set @muscle_ideal = case 
	WHEN (@height < 1.60) THEN '38.5% - 46.5%'
	WHEN (@height >= 1.60) and (@height < 1.75) THEN '44% - 52.5%'
	WHEN (@height >= 1.75)  THEN '49.5% - 59.5%'
    ELSE 'XD'
  END
RETURN @muscle_ideal
END

select [dbo].[muscle_percentage_ideal](1.75,'M')
--peso ideal
CREATE FUNCTION weight_ideal (@height decimal(3,2),@sex char(1) , @body_texture varchar(8))
returns varchar(10)
AS
BEGIN
  declare @weight_ideal varchar(max)
  if(@sex = 'F')
    if(@body_texture = 'Pequeña')
      set @weight_ideal  = case 
	    WHEN (@height = 1.47) THEN '42kg-45kg'
      WHEN (@height = 1.50) THEN '43kg-46kg'
      WHEN (@height = 1.52) THEN '44kg-47kg'
      WHEN (@height = 1.55) THEN '45kg-49kg'
      WHEN (@height = 1.57) THEN '46kg-50kg'
      WHEN (@height = 1.60) THEN '48kg-51kg'
      WHEN (@height = 1.62) THEN '49kg-53kg'
      WHEN (@height = 1.65) THEN '51kg-54kg'
      WHEN (@height = 1.68) THEN '52kg-56kg'
      WHEN (@height = 1.70) THEN '54kg-58kg'
      WHEN (@height = 1.73) THEN '56kg-60kg'
      WHEN (@height = 1.75) THEN '57kg-61kg'
      WHEN (@height = 1.78) THEN '59kg-64kg'
      WHEN (@height = 1.80) THEN '61kg-66kg'
      WHEN (@height = 1.83) THEN '63kg-67kg'
      ELSE 'upsi'
      END
    if(@body_texture = 'Mediana')
       set @weight_ideal  = case 
	    WHEN (@height = 1.47) THEN '44kg-49kg'
      WHEN (@height = 1.50) THEN '45kg-50kg'
      WHEN (@height = 1.52) THEN '46kg-51kg'
      WHEN (@height = 1.55) THEN '47kg-53kg'
      WHEN (@height = 1.57) THEN '49kg-54kg'
      WHEN (@height = 1.60) THEN '50kg-56kg'
      WHEN (@height = 1.62) THEN '51kg-57kg'
      WHEN (@height = 1.65) THEN '53kg-59kg'
      WHEN (@height = 1.68) THEN '55kg-61kg'
      WHEN (@height = 1.70) THEN '56kg-63kg'
      WHEN (@height = 1.73) THEN '58kg-65kg'
      WHEN (@height = 1.75) THEN '60kg-67kg'
      WHEN (@height = 1.78) THEN '62kg-69kg'
      WHEN (@height = 1.80) THEN '64kg-71kg'
      WHEN (@height = 1.83) THEN '66kg-72kg'
      ELSE 'upsi'
      END
    if(@body_texture = 'Grande')
      set @weight_ideal  = case 
	    WHEN (@height = 1.47) THEN '47kg-54kg'
      WHEN (@height = 1.50) THEN '48kg-56kg'
      WHEN (@height = 1.52) THEN '50kg-58kg'
      WHEN (@height = 1.55) THEN '51kg-59kg'
      WHEN (@height = 1.57) THEN '52kg-60kg'
      WHEN (@height = 1.60) THEN '54kg-61kg'
      WHEN (@height = 1.62) THEN '55kg-63kg'
      WHEN (@height = 1.65) THEN '57kg-65kg'
      WHEN (@height = 1.68) THEN '58kg-66kg'
      WHEN (@height = 1.70) THEN '60kg-68kg'
      WHEN (@height = 1.73) THEN '62kg-70kg'
      WHEN (@height = 1.75) THEN '64kg-72kg'
      WHEN (@height = 1.78) THEN '66kg-74kg'
      WHEN (@height = 1.80) THEN '67kg-76kg'
      WHEN (@height = 1.83) THEN '70kg-79kg'
      ELSE 'upsi'
      END

  ELSE 
     if(@body_texture = 'Pequeña')
  set @weight_ideal  = case 
	   WHEN (@height = 1.57) THEN '51kg-55kg'
     WHEN (@height = 1.60) THEN '52kg-56kg'
     WHEN (@height = 1.62) THEN '54kg-57kg'
     WHEN (@height = 1.65) THEN '55kg-59kg'
     WHEN (@height = 1.68) THEN '56kg-60kg'
     WHEN (@height = 1.70) THEN '58kg-62kg'
     WHEN (@height = 1.73) THEN '60kg-64kg'
     WHEN (@height = 1.75) THEN '62kg-66kg'
     WHEN (@height = 1.78) THEN '64kg-68kg'
     WHEN (@height = 1.80) THEN '66kg-70kg'
     WHEN (@height = 1.83) THEN '67kg-72kg'
     WHEN (@height = 1.85) THEN '69kg-74kg'
     WHEN (@height = 1.88) THEN '71kg-76kg'
     WHEN (@height = 1.90) THEN '73kg-78kg'
     WHEN (@height = 1.93) THEN '75kg-80kg'
      ELSE 'ups'
  END
    if(@body_texture = 'Mediana')
    set @weight_ideal  = case 
	   WHEN (@height = 1.57) THEN '54kg-59kg'
     WHEN (@height = 1.60) THEN '55kg-60kg'
     WHEN (@height = 1.62) THEN '56kg-62kg'
     WHEN (@height = 1.65) THEN '58kg-63kg'
     WHEN (@height = 1.68) THEN '59kg-65kg'
     WHEN (@height = 1.70) THEN '61kg-67kg'
     WHEN (@height = 1.73) THEN '63kg-69kg'
     WHEN (@height = 1.75) THEN '65kg-71kg'
     WHEN (@height = 1.78) THEN '66kg-73kg'
     WHEN (@height = 1.80) THEN '68kg-75kg'
     WHEN (@height = 1.83) THEN '70kg-77kg'
     WHEN (@height = 1.85) THEN '72kg-80kg'
     WHEN (@height = 1.88) THEN '74kg-82kg'
     WHEN (@height = 1.90) THEN '76kg-84kg'
     WHEN (@height = 1.93) THEN '78kg-86kg'
      ELSE 'ups'
  END
    if(@body_texture = 'Grande')
    set @weight_ideal  = case 
	   WHEN (@height = 1.57) THEN '57kg-64kg'
     WHEN (@height = 1.60) THEN '59kg-66kg'
     WHEN (@height = 1.62) THEN '60kg-67kg'
     WHEN (@height = 1.65) THEN '61kg-69kg'
     WHEN (@height = 1.68) THEN '63kg-71kg'
     WHEN (@height = 1.70) THEN '65kg-73kg'
     WHEN (@height = 1.73) THEN '67kg-75kg'
     WHEN (@height = 1.75) THEN '69kg-77kg'
     WHEN (@height = 1.78) THEN '71kg-79kg'
     WHEN (@height = 1.80) THEN '72kg-81kg'
     WHEN (@height = 1.83) THEN '75kg-84kg'
     WHEN (@height = 1.85) THEN '76kg-86kg'
     WHEN (@height = 1.88) THEN '79kg-82kg'
     WHEN (@height = 1.90) THEN '88kg-91kg'
     WHEN (@height = 1.93) THEN '83kg-93kg'
      ELSE 'ups'
  END
RETURN @weight_ideal
END

select [dbo].[weight_ideal](1.75,'M','Median')
--porcentaje grasa 
CREATE FUNCTION fat_ideal (@age smallint, @sex char(1))
returns varchar(10)
AS
BEGIN
  declare @fat varchar(10)
  if(@sex = 'F')
  set @fat = case 
	WHEN (@age > 10 ) and (@age < 30 ) THEN '20% - 26%'
	WHEN (@age > 30) and (@age < 40) THEN '21% - 27%'
	WHEN (@age > 41)  and (@age < 50) THEN '22% - 28%'
  WHEN (@age > 51)  and (@age < 60) THEN '22% - 30%'
  WHEN (@age < 61) THEN '22% -31'
  ELSE 'XD'
  END
  ELSE 
  set @fat = case 
	WHEN (@age > 10 ) and (@age < 30 ) THEN '12% - 18%'
	WHEN (@age > 30) and (@age < 40) THEN '13% - 19%'
	WHEN (@age > 41)  and (@age < 50) THEN '14% - 20%'
  WHEN (@age > 51)  and (@age < 60) THEN '16% - 20%'
  WHEN (@age < 61) THEN '17% -21%'
    ELSE 'XD'
  END
RETURN @fat
END

select [dbo].[fat_ideal](24,'M')
--grasa viceral
CREATE FUNCTION viceral_fat_ideal (@viseral_fat decimal(4,2))
returns varchar(16)
AS
BEGIN
    declare @viseral_fat_ideal varchar(16)
    set @viseral_fat_ideal = case 
	WHEN (@viseral_fat >= 1) and (@viseral_fat <= 9) THEN 'Normal'
	WHEN (@viseral_fat >= 10) and (@viseral_fat < 14) THEN 'Alta'
	WHEN (@viseral_fat > 14)  THEN 'Muy alta'
    ELSE 'Fatal viceral fat'
  END
RETURN @viseral_fat_ideal
END

select [dbo].[viceral_fat_ideal](9)



CREATE PROCEDURE pa_get_measurement_ideal @id_measuring int
AS
BEGIN TRY
   BEGIN TRANSACTION
   select [dbo].[weight_ideal](cl.height,cl.sex,cl.body_texture) as weight_ideal,
   [dbo].[fat_ideal](cl.age,cl.sex) as fat_ideal,
   [dbo].[viceral_fat_ideal](m.viseral_fat_percentage) as viceral_fat_ideal,
   [dbo].[muscle_percentage_ideal](cl.height,cl.sex) as muscle_percentage_ideal
	  from appointment as app
	  join date_client as dc on dc.fk_appointment = app.id_appointment
	  join client as cl on  cl. id_card_client =  dc.fk_cr_client
	  join measuring as m on m.appointment = app.id_appointment
    where m.id_measuring = @id_measuring
   COMMIT TRANSACTION
END TRY
BEGIN CATCH
   ROLLBACK TRANSACTION
END CATCH

--procedimiento de evolucion

--peso
create function fn_evo_weight (@id_evo_one int , @id_evo_two int)
returns smallint
as
begin
  declare @evoOne smallint
  declare @evoTwo smallint
  declare @result smallint

set @evoOne = (select mea.weight_client
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select mea.weight_client
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end
--grasa
create function fn_evo_fat (@id_evo_one int , @id_evo_two int)
returns DECIMAL(4,2)
as
begin
  declare @evoOne DECIMAL(4,2)
  declare @evoTwo DECIMAL(4,2)
  declare @result DECIMAL(4,2)

set @evoOne = (select mea.fat_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select mea.fat_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end
--musculo
create function fn_evo_muscle (@id_evo_one int , @id_evo_two int)
returns DECIMAL(4,2)
as
begin
  declare @evoOne DECIMAL(4,2)
  declare @evoTwo DECIMAL(4,2)
  declare @result DECIMAL(4,2)

set @evoOne = (select mea.muscle_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select mea.muscle_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end

--grasa viceral
create function fn_evo_viseralFat (@id_evo_one int , @id_evo_two int)
returns DECIMAL(4,2)
as
begin
  declare @evoOne DECIMAL(4,2)
  declare @evoTwo DECIMAL(4,2)
  declare @result DECIMAL(4,2)

set @evoOne = (select mea.viseral_fat_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select mea.viseral_fat_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end
--imc
create function fn_evo_imc (@id_evo_one int , @id_evo_two int)
returns DECIMAL(4,2)
as
begin
  declare @evoOne DECIMAL(4,2)
  declare @evoTwo DECIMAL(4,2)
  declare @result DECIMAL(4,2)

set @evoOne = (select [dbo].[fn_calculate_imc](cli.height,mea.weight_client)
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select [dbo].[fn_calculate_imc](cli.height,mea.weight_client)
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end
--edad metabolica
create function fn_evo_metabolicAge(@id_evo_one int , @id_evo_two int)
returns TINYINT
as
begin
  declare @evoOne TINYINT
  declare @evoTwo TINYINT
  declare @result TINYINT

set @evoOne = (select mea.metabolic_age
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_one)

set @evoTwo = (select mea.metabolic_age
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @id_evo_two)

set @result =( @evoTwo-@evoOne)
return @result
end

--el procedimiento

CREATE PROCEDURE sp_get_evolution @idOne int , @idTwo int
as
begin try
 begin transaction 
 
 select mea.weight_client,mea.fat_percentage,mea.muscle_percentage,mea.viseral_fat_percentage,mea.metabolic_age,
[dbo].[fn_calculate_imc](cli.height,mea.weight_client) as imc,
[dbo].[fn_evo_weight](@idOne,@idTwo) as peso,[dbo].[fn_evo_fat](@idOne,@idTwo) as fat, [dbo].[fn_evo_muscle](@idOne,@idTwo) as musculo,
[dbo].[fn_evo_viseralFat](@idOne,@idTwo) as viseral_fat ,[dbo].[fn_evo_metabolicAge](@idOne,@idTwo) as age_metabolic ,
[dbo].[fn_evo_imc](@idOne,@idTwo) as imcEvo
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
where mea.id_measuring = @idOne or mea.id_measuring = @idTwo
 commit transaction
end try
 begin catch
   rollback transaction
 end catch

--rutina o algo asi xd
create PROCEDURE sp_grind_exercises
as 
begin try
 begin transaction 
   select top 10 ex.name_exercise , ex.exercised_area from exercises as ex
    join muscle_group as mg on mg.id_zone_moscular = ex.id_exercise
     order by NEWID()
  commit transaction
end try
 begin catch
   rollback transaction
 end catch
--procedimiento
create PROCEDURE sp_grind(@customer VARCHAR(15))
as 
begin try
 begin transaction 
    declare @create_date date
    declare @expiration_date date
    set @create_date = (select CONVERT (date, GETDATE()))
    set @expiration_date = (select DATEADD(MONTH,3,(select CONVERT (date, GETDATE()))))
    insert into grind
    values(@create_date,@expiration_date,@customer)
	execute [dbo].[sp_grind_exercises]
  commit transaction
end try
 begin catch
   rollback transaction
 end catch
--base reportes

create view vw_base_reports
as
 select p.date_appointment, mea.id_measuring, mea.weight_client,mea.fat_percentage,mea.muscle_percentage,mea.viseral_fat_percentage,cli.age,
[dbo].[fn_calculate_imc](cli.height,mea.weight_client) as imc,
[dbo].[weight_ideal](cli.height,cli.sex,cli.body_texture) as weight_ideal,
[dbo].[fat_ideal](cli.age,cli.sex) as fat_ideal,
[dbo].[muscle_percentage_ideal](cli.height,cli.sex) as muscle_ideal,
[dbo].[viceral_fat_ideal](mea.viseral_fat_percentage) as viceral_fat_ideal,
mea.metabolic_age,
[dbo].[fn_glasses_water](mea.weight_client) as cant_water_everyday,
[dbo].[fn_cant_protein](mea.id_measuring) as cant_protein_everyday,
cli.body_texture
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment 


create view vw_base_reportsTwo
as
select * , [dbo].[fn_classification_imc](imc) as clasification_imc from [dbo].[vw_base_reports] 

--procedimiento generar reporte bienestar
CREATE PROCEDURE pa_generate_report_wellness @id int
AS
   BEGIN TRY
      select p.date_appointment, mea.id_measuring, mea.weight_client,mea.fat_percentage,mea.muscle_percentage,mea.viseral_fat_percentage,cli.age,
[dbo].[fn_calculate_imc](cli.height,mea.weight_client) as imc,
[dbo].[weight_ideal](cli.height,cli.sex,cli.body_texture) as weight_ideal,
[dbo].[fat_ideal](cli.age,cli.sex) as fat_ideal,
[dbo].[muscle_percentage_ideal](cli.height,cli.sex) as muscle_ideal,
[dbo].[viceral_fat_ideal](mea.viseral_fat_percentage) as viceral_fat_ideal,
mea.metabolic_age,
[dbo].[fn_glasses_water](mea.weight_client) as cant_water_everyday,
[dbo].[fn_cant_protein](mea.id_measuring) as cant_protein_everyday
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment 
where  mea.id_measuring = @id

   END TRY
   BEGIN CATCH
       ROLLBACK TRANSACTION
   END CATCH
--version dos 
CREATE PROCEDURE pa_generate_report_wellness @id int
AS
   BEGIN TRY
     select id_measuring,date_appointment,weight_client,weight_ideal,imc,fat_percentage,fat_ideal,
	 muscle_percentage,muscle_ideal,viseral_fat_percentage,viceral_fat_ideal,age,metabolic_age,
	 [dbo].[fn_ailments_imc](clasification_imc) as ailments,cant_water_everyday,cant_protein_everyday
	 from [dbo].[vw_base_reportsTwo] 
     where  id_measuring = @id
   END TRY
   BEGIN CATCH
       ROLLBACK TRANSACTION
   END CATCH

--reporte
CREATE VIEW vw_report_client
AS
select cli.name_client,cpus.campus_name,cli.age,cli.height,cli.affilieted_instructor,mea.weight_client,
[dbo].[fn_calculate_imc](cli.height,mea.weight_client) as imc,
mea.fat_percentage,mea.viseral_fat_percentage
from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.id_measuring = p.id_appointment
inner join client_campus as clic on clic.client = cli.id_card_client
inner join campus as cpus on cpus.id_campus = clic.campus


