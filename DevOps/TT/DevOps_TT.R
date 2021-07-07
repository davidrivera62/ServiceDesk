DevOps_TT <- function(x){
  
  source("dbconn.R")
  
  DevOps_TT <- c()
  
  dbconnection <- dbconn()
  
  result <- dbSendQuery(dbconnection,
                        " /*En esta version.
 *Se eliminó elementos duplicados en los resultados de la consulta.
*/
SELECT 
dbo.call_req.ref_num AS NUM_TICKET ,
dbo.prob_ctg.sym AS AREA_INCIDENTE,
call_req.description AS DESCRIPCION_TICKET,

dbo.usp_resolution_code.sym AS 'CODIGO_SOLUCION',dbo.ca_owned_resource.resource_name AS SERVICIO_EMPRESARIAL,

ANALISTA_RESPONSABLE_CIERRE = CASE dbo.call_req.assignee    
    
when 0x199726DAE0601C488E848729B18717A6 then 'Johan Borges'
when 0x81A9F93E9FDE5F42B574B59FB7787A38 then 'Carlos Olivero'
when 0xA0BF2E7458878F4EB96BB824CEEA4CCB then 'Gustavo Tangarife'
when 0xE88D9B474634334DA260F7A01C12CED9 then 'Carolina Mejia'
when 0x10195FFA47EF5A48BAC73BDD217BF749 then 'Andres Pulgarin'
when 0xC723B6487EE52447AA0A39592C20E6EF then 'Bibiana Restrepo'
when 0xA0D05C8CB9D65C4A837DE8ED55EA0BB5 then 'Camilo Bedoya'
when 0x3D2A9C319477DF4288322FAAF8FAD956 then 'Carolina Tejada'
when 0x9D6DE3DA438B6E44BD530CFB87164186 then 'Diana Saldarriaga'
when 0x1A6911EB454C494FA5FF4776AA3F1C74 then 'Diana Valencia'
when 0xDB567ACC64200D4989E64AD8E31D2BCD then 'Ricardo Berbeo'
when 0xB2C4D2EEE56F3E4E859ED8E59371549B then 'Jorge Villegas'

END,
GESTIONADO_DEVOPS = CASE  dbo.call_req.group_id WHEN 0xC5A1E42EEED4E04487E9FF4A2CF24DE0 THEN 'GRUPO SOPORTE Y DLLO DEVOPS' END,
dbo.call_req.parent AS INCIDENTE_PADRE,
rootcause.sym AS CAUSA_RAIZ,
usp_symptom_code.sym AS SINTOMA,
usp_resolution_code.sym AS COD_SOLUCION,
usp_resolution_method.sym AS METODO_SOLUCION,
dbo.pri.sym AS PRIORIDAD,dbo.impact.sym AS IMPACTO,
dbo.cr_stat.sym AS ESTADO_TICKET,
dbo.ca_contact.first_name AS NOMBRE_QUIEN_REPORTA,
dbo.ca_contact.last_name AS APELLIDO_QUIEN_REPORTA,
dbo.call_req.sla_violation AS SLA_VIOLATION,
DATEADD(HH,-5,(DATEADD(ss,open_date, '19700101 00:00:00')))AS FECHA_INICIO_TICKET,
DATEADD(HH,-5,(DATEADD(ss,close_date, '19700101 00:00:00'))) AS FECHA_CIERRE_TICKET, 
DATEADD(HH,-5,(DATEADD(ss,outage_start_time, '19700101 00:00:00:00'))) AS FECHA_REAL_INICIO_TICKET,
DATEADD(HH,-5,(DATEADD(ss,outage_end_time, '19700101 00:00:00:00'))) FECHA_SOLUCION_TICKET,
ABS((outage_start_time-outage_end_time)/60) AS DIFERENCIA_MINUTOS_Outage,
ABS((outage_start_time-outage_end_time)/3600) AS DIFERENCIA_HORA_CIERRE_Outage,
ABS((open_date-close_date)/60) AS DIFERENCIA_MINUTOS_APERTURA_CIERRE,
outage_detail_who AS 'QUIEN',
outage_detail_what AS 'QUE_CAUSO',
outage_reason_desc AS 'RAZON_INDISPONIBILIDAD'        
FROM dbo.call_req

LEFT JOIN dbo.interface ON dbo.interface.id=dbo.call_req.created_via  
LEFT JOIN dbo.prob_ctg ON dbo.prob_ctg.persid=dbo.call_req.category    
LEFT JOIN dbo.cr_stat ON dbo.cr_stat.code=dbo.call_req.status    
LEFT JOIN dbo.impact ON dbo.impact.enum=dbo.call_req.impact    
LEFT JOIN dbo.pri ON dbo.pri.enum=dbo.call_req.priority     
LEFT JOIN dbo.ca_contact ON  dbo.ca_contact.contact_uuid= dbo.call_req.log_agent
LEFT JOIN dbo.usp_resolution_code on dbo.call_req.resolution_code=dbo.usp_resolution_code.id
LEFT JOIN rootcause on rootcause.id = call_req.rootcause
LEFT JOIN usp_symptom_code on usp_symptom_code.id = call_req.symptom_code 
LEFT JOIN usp_resolution_method on usp_resolution_method.id = call_req.resolution_method
LEFT JOIN dbo.ca_owned_resource ON dbo.call_req.affected_service= dbo.ca_owned_resource.own_resource_uuid                 

WHERE active_flag=0
AND CONVERT (date,DATEADD(ss, open_date, '19700101 00:00:00:000')) BETWEEN '2020-01-01' AND '2021-12-31' 
AND dbo.call_req.type='I' AND dbo.call_req.group_id=0xC5A1E42EEED4E04487E9FF4A2CF24DE0
AND dbo.prob_ctg.sym LIKE'%GTT%' ORDER BY dbo.call_req.ref_num"
  )
  
  DevOps_TT <- dbFetch(result)
  
  
  return(DevOps_TT)
  
}