; docformat = 'IDL'

;+
;
;Name:
;IUG_CREATE_QUERY_IRI2012
;
;Purpose:
;To create query for iri2012.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_create_query_iri2012,1,2000,0,0,100
;-
pro iug_create_query_iri2012,jmag=jmag,lat=lat,lon=lon,yyyy=yyyy,mm=mm,dd=dd,ltut=ltut,atime=atime,height=height

  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)'+'/'
  
  openw, unit, tmp_dir+'iri2012.sql',/get_lun ; create query file

  printf,unit,'.output '+tmp_dir+'iri2012.result'
  printf,unit,'.separator ","'

  printf,unit,'select * from iri2012 where jmag='+strtrim(string(jmag),1)+' and lat='+strtrim(string(lat),1)+' and lon='+strtrim(string(lon),1)+' and yyyy='+strtrim(string(yyyy),1)+' and mm='+strtrim(string(mm),1)+' and dd='+strtrim(string(dd),1)+' and ltut='+strtrim(string(ltut),1)+' and atime='+strtrim(string(atime),1)+' and height='+strtrim(string(height),1)+";"
  free_lun, unit
end
