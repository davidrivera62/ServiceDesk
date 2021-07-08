DevOps_TT <- function(x){
  
  source("dbconn.R")
  
  DevOps_TT <- c()
  
  dbconnection <- dbconn()
  
  result <- dbSendQuery(dbconnection,
                        "SELECT 
dbo.call_req.ref_num AS NUM_TICKET ,
dbo.prob_ctg.sym AS AREA_INCIDENTE,
call_req.description AS DESCRIPCION_TICKET,
dbo.usp_resolution_code.sym AS 'CODIGO_SOLUCION',
dbo.ca_owned_resource.resource_name AS SERVICIO_EMPRESARIAL,
(analista.first_name + ' ' + analista.last_name) AS ANALISTA_RESPONSABLE_CIERRE,
GESTIONADO_DEVOPS = CASE  dbo.call_req.group_id WHEN 0xC5A1E42EEED4E04487E9FF4A2CF24DE0 THEN 'GRUPO SOPORTE Y DLLO DEVOPS' END,
rootcause.sym AS CAUSA_RAIZ,
usp_symptom_code.sym AS SINTOMA,
usp_resolution_code.sym AS COD_SOLUCION,
usp_resolution_method.sym AS METODO_SOLUCION,
dbo.pri.sym AS PRIORIDAD,dbo.impact.sym AS IMPACTO,
dbo.cr_stat.sym AS ESTADO_TICKET,
(solicitante.first_name + ' ' + solicitante.last_name) AS REPORTADO_POR,
DATEADD(HH,-5,(DATEADD(ss,open_date, '19700101 00:00:00')))AS FECHA_INICIO_TICKET,
DATEADD(HH,-5,(DATEADD(ss,close_date, '19700101 00:00:00'))) AS FECHA_CIERRE_TICKET, 
DATEADD(HH,-5,(DATEADD(ss,outage_start_time, '19700101 00:00:00:00'))) AS FECHA_REAL_INICIO_TICKET,
DATEADD(HH,-5,(DATEADD(ss,outage_end_time, '19700101 00:00:00:00'))) FECHA_SOLUCION_TICKET,
ABS((outage_start_time-outage_end_time)/60) AS DIFERENCIA_MINUTOS_Outage,
ABS((outage_start_time-outage_end_time)/3600) AS DIFERENCIA_HORA_CIERRE_Outage,
ABS((open_date-close_date)/60) AS DIFERENCIA_MINUTOS_APERTURA_CIERRE,
outage_detail_who AS 'QUIEN',
outage_detail_what AS 'QUE_CAUSO',
outage_reason_desc AS 'RAZON_INDISPONIBILIDAD',
SLA_ESTADO = CASE
WHEN dbo.impact.sym = '1 Alto' AND ABS((open_date-close_date)/60) <=60*4 THEN 'CUMPLE'
WHEN dbo.impact.sym = '1 Alto' AND ABS((open_date-close_date)/60) >60*4 THEN 'INCUMPLE'
WHEN dbo.impact.sym = '3 Medio' AND ABS((open_date-close_date)/60) <=60*16 THEN 'CUMPLE'
WHEN dbo.impact.sym = '3 Medio' AND ABS((open_date-close_date)/60) >60*16 THEN 'INCUMPLE'
WHEN dbo.impact.sym = '5 Bajo' AND ABS((open_date-close_date)/60) <=60*72 THEN 'CUMPLE'
WHEN dbo.impact.sym = '5 Bajo' AND ABS((open_date-close_date)/60) >60*72 THEN 'INCUMPLE'
WHEN dbo.impact.sym = 'Ninguno' AND ABS((open_date-close_date)/60) <=60*72 THEN 'CUMPLE'
WHEN dbo.impact.sym = 'Ninguno' AND ABS((open_date-close_date)/60) >60*72 THEN 'INCUMPLE'
ELSE 'SLA No Identificado' END,  
SLA_EVALUADO = CASE
WHEN dbo.impact.sym = '1 Alto' THEN 'SLA 1'
WHEN dbo.impact.sym = '3 Medio' THEN 'SLA 2' 
WHEN dbo.impact.sym = '5 Bajo' THEN 'SLA 3'
WHEN dbo.impact.sym = 'Ninguno' THEN 'SLA 3'
ELSE 'No Identificado' END,
ATRIBUCION = CASE 
WHEN CONVERT (VARCHAR,dbo.call_req.outage_detail_who) = 'I' THEN 'Infraestructura'
WHEN CONVERT (VARCHAR,dbo.call_req.outage_detail_who) = 'O' THEN 'Operación'
WHEN CONVERT (VARCHAR,dbo.call_req.outage_detail_who) IS NULL THEN 'Operación'
WHEN CONVERT (VARCHAR,dbo.call_req.outage_detail_who) = ' ' THEN 'Operación'
WHEN CONVERT (VARCHAR,dbo.call_req.outage_detail_who) = 'D' THEN 'Desarrollo'
ELSE 'No Identificada' END

FROM 
dbo.call_req
LEFT JOIN dbo.interface ON dbo.interface.id=dbo.call_req.created_via  
LEFT JOIN dbo.prob_ctg ON dbo.prob_ctg.persid=dbo.call_req.category    
LEFT JOIN dbo.cr_stat ON dbo.cr_stat.code=dbo.call_req.status    
LEFT JOIN dbo.impact ON dbo.impact.enum=dbo.call_req.impact    
LEFT JOIN dbo.pri ON dbo.pri.enum=dbo.call_req.priority     
LEFT JOIN dbo.ca_contact AS solicitante ON  solicitante.contact_uuid = dbo.call_req.requested_by
LEFT JOIN dbo.ca_contact AS analista ON analista.contact_uuid = dbo.call_req.assignee
LEFT JOIN dbo.usp_resolution_code ON dbo.call_req.resolution_code=dbo.usp_resolution_code.id
LEFT JOIN rootcause ON rootcause.id = call_req.rootcause
LEFT JOIN usp_symptom_code ON usp_symptom_code.id = call_req.symptom_code 
LEFT JOIN usp_resolution_method ON usp_resolution_method.id = call_req.resolution_method
LEFT JOIN dbo.ca_owned_resource ON dbo.call_req.affected_service= dbo.ca_owned_resource.own_resource_uuid                 

WHERE 
active_flag=0
AND CONVERT (date,DATEADD(ss, open_date, '19700101 00:00:00:000')) BETWEEN '2021-01-01' AND '2021-12-31' 
AND dbo.call_req.type='I' AND dbo.call_req.group_id=0xC5A1E42EEED4E04487E9FF4A2CF24DE0
AND dbo.prob_ctg.sym LIKE'%GTT%' ORDER BY dbo.call_req.ref_num"
  )
  
  DevOps_TT <- dbFetch(result)
  
  
  return(DevOps_TT)
  
}