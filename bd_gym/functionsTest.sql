--fn 1 calcular imc
select cli.name_client,[dbo].[fn_calculate_imc](cli.height,mea.weight_client) as imc from appointment as p
inner join date_client as dcli on dcli.fk_appointment = p.id_appointment
inner join client as cli on cli.id_card_client= dcli.fk_cr_client
inner join measuring as mea on mea.appointment = p.id_appointment
--f2- clasificar imc
select [dbo].[fn_classification_imc](10) as clasi
--f3 edad
select [dbo].[fn_age]('1996-01-12') as edad
--f5
--tr edad
--f6 vasos de agua
select dbo.fn_glasses_water(60) as awa
--f8 proteina
select [dbo].[fn_cant_protein](1)
--f9 obtener medidas ideales
execute [dbo].[pa_get_measurement_ideal] 1
--f10 evolucion
execute [dbo].[sp_get_evolution] 1 ,5
--f11 rutina
execute [dbo].[sp_grind] '060439045'
--f12 generar reporte bienestar
execute [dbo].[pa_generate_report_wellness] 1
--f13 vista reporte cliente
select * from [dbo].[vw_report_client]

