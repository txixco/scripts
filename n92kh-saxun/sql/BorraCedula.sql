use genesis

delete from entradascedula
where rce_numero in (select rce_numero 
					from reciboscedula 
					where cdu_numero in (select cdu_numero
										from cedula 
										where sol_numero = 170107))

delete from reciboscedula
where cdu_numero in (select cdu_numero
					from cedula
					where sol_numero = 170107)

delete from bitacoracedula
where cdu_numero in (select cdu_numero
					from cedula
					where sol_numero = 170107)

delete from edoscedula
where cdu_numero in (select cdu_numero
					from cedula
					where sol_numero = 170107)

delete from otroscedula
where cdu_numero in (select cdu_numero
					from cedula
					where sol_numero = 170107)

delete from cedula
where sol_numero = 170107