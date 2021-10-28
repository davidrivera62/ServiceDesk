OC <- function(x){
  
  source("dbconn.R")
  
  OC <- c()

  dbconnection <- dbconn()
  
  result <- dbSendQuery(dbconnection, 
                        "
                        SELECT 
dbo.chg.chg_ref_num AS NUM_OC,
(analista.first_name + ' ' + analista.last_name) AS ANALISTA_RESPONSANBLE_CIERRE_TAREA,
dbo.wf.status AS ESTADO_TAREA,
dbo.usp_closure_code.sym AS CODIGO_CIERRE,
dbo.ca_contact.first_name AS NOMBRE_QUIEN_SOLICITA,
dbo.ca_contact.last_name AS APELLIDO_QUIEN_SOLICITA,
dbo.chgcat.sym AS CATEGORIA_OC,
dbo.wf.sequence AS SEC_TAREA,
DATEADD(HH,-5,(DATEADD(ss, dbo.wf.start_date, '19700101 00:00:00'))) AS FECHA_INICIO_TAREA,
DATEADD(HH,-5,(DATEADD(ss, dbo.wf.completion_date, '19700101 00:00:00'))) AS FECHA_CIERRE_TAREA,
ABS((wf.start_date - wf.last_mod_dt)/60) AS DIFERENCIA_MINUTOS_CERRADO_TAREA,
dbo.wf.description AS COMENTARIO_ANALISTA_TAREA_,  
DATEADD(HH,-5,(DATEADD(ss, dbo.chg.sched_start_date, '19700101 00:00:00'))) AS FECHA_INICIO_TAREA_PROGRAMADA,
DATEADD(HH,-5,(DATEADD(ss, dbo.chg.sched_end_date, '19700101 00:00:00'))) AS FECHA_CIERRE_TAREA_PROGRAMADA,
abs((chg. sched_start_date- chg.sched_end_date)/60) AS DIFERENCIA_MINUTOS_CERRADO_TAREA_PROGRAMADA,
OPERACION = CASE 
WHEN dbo.chgcat.sym LIKE '%.Semilla%' THEN 'Móvil' 
WHEN dbo.chgcat.sym LIKE '%WL12C%' THEN 'Móvil'
WHEN dbo.chgcat.sym LIKE '%Movil%' THEN 'Móvil'
ELSE 'Fijo' END,
SLA_EVALUADO = CASE
WHEN dbo.chgcat.sym LIKE '%.crear.permisos%' THEN 'SLA 4'
WHEN dbo.chgcat.sym LIKE '%.ActualizacionAmbiente.Semilla%' THEN 'SLA 5' 
WHEN dbo.chgcat.sym LIKE '%.HomologacionAmbiente.Planchado%' THEN 'SLA 6'
WHEN dbo.chgcat.sym LIKE '%.retirar.permisos%' THEN 'SLA 7'
WHEN dbo.chgcat.sym LIKE '%.reseteo.permisos%' THEN 'SLA 9'
WHEN dbo.chgcat.sym LIKE '%Semilla.CertificacionAmbiente%' THEN 'SLA 12'
WHEN dbo.chgcat.sym LIKE '%Itpam.dia%' THEN 'No Aplica'
WHEN dbo.chgcat.sym LIKE '%Catalogo.Apl%' THEN 'No Aplica'
ELSE 'SLA 8' END,
SLA_ESTADO = CASE
WHEN dbo.chgcat.sym LIKE '%.crear.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*24 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%.crear.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*24 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%.ActualizacionAmbiente.Semilla%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*8 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%.ActualizacionAmbiente.Semilla%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*8 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%Semilla.CertificacionAmbiente%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*8 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%Semilla.CertificacionAmbiente%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*8 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%.HomologacionAmbiente.Planchado%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*120 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%.HomologacionAmbiente.Planchado%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*120 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%.retirar.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*4 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%.retirar.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*4 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%.reseteo.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) <=60*6 THEN 'CUMPLE'
WHEN dbo.chgcat.sym LIKE '%.reseteo.permisos%' AND ABS((wf.start_date - wf.last_mod_dt)/60) >60*6 THEN 'INCUMPLE'
WHEN dbo.chgcat.sym LIKE '%Itpam.dia%' THEN 'No Aplica'
WHEN dbo.chgcat.sym LIKE '%Catalogo.Apl%' THEN 'No Aplica'
WHEN ABS((wf.start_date - wf.last_mod_dt)/60) <=60*4 THEN 'CUMPLE'
WHEN ABS((wf.start_date - wf.last_mod_dt)/60) >60*4 THEN 'INCUMPLE'
ELSE 'No Evaluado' END

FROM 
chg          
LEFT JOIN dbo.chgcat ON dbo.chgcat.code=dbo.chg.category     
LEFT JOIN dbo.wf ON dbo.wf.object_id=dbo.chg.id     
LEFT JOIN dbo.ca_contact ON  dbo.ca_contact.contact_uuid= dbo.chg.requestor
LEFT JOIN dbo.ca_contact AS analista ON analista.contact_uuid = dbo.wf.last_mod_by
LEFT JOIN dbo.usp_closure_code ON dbo.usp_closure_code.id = dbo.chg.closure_code

WHERE 
dbo.wf.group_id= 0x8606FE2A25E99944A17B99560ED08207 
AND dbo.wf.status<>'WAIT' 
AND dbo.wf.status<>'PEND' 
AND dbo.wf.sequence = 10
AND dbo.chgcat.code != 'OCDEPAO'
AND CONVERT (date,DATEADD(ss, open_date, '19700101 00:00:00:000')) BETWEEN '2021-01-01' AND '2021-12-31' ORDER BY dbo.chg.chg_ref_num
                        
                        "
  )
  OC <- dbFetch(result)

  
  return(OC)
}
