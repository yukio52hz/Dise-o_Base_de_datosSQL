--consulta de prueba xd
SELECT c.campus_name,e.employee_name FROM campus as c
inner join employee as e on c.id_campus = e.campus 

--ver los empleados instructores
SELECT * FROM campus as c
inner join employee as e on c.id_campus = e.campus 
inner join instructor as i on i.id_instruc =  e.indentification_card 
--ver los certificados del intructor
SELECT c.campus_name, e.indentification_card, e.employee_name as instructor,cc.name_certifications FROM campus as c
inner join employee as e on c.id_campus = e.campus 
inner join instructor as i on i.id_instruc =  e.indentification_card
inner join certifications as cc on cc.id_instructor = i.id_employee
--administradores
SELECT c.campus_name, e.employee_name, i.position FROM campus as c
inner join employee as e on c.id_campus = e.campus 
inner join administrator as i on i.id_admin =  e.indentification_card
--cliente con su cita y medidas
select * from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.appointment = p.id_appointment
--cita programa
select p.date_appointment,em.employee_name,cli.name_client from appointment as p
inner join date_instructor as di on di.fk_appointment=p.id_appointment
inner join instructor as i on i.id_employee =di.fk_cr_instructor
inner join employee as em on em.indentification_card = i.id_instruc

inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.appointment = p.id_appointment
--sede y cliente
select cc.campus_name,c.name_client,c.sex from client as c
inner join client_campus as cps on cps.client = c.id_card_client
inner join campus as cc on cc.id_campus = cps.campus