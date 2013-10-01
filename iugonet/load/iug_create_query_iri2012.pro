; docformat = 'IDL'

;+
;
;Name:
;IUG_CREATE_QUERY_IRI2012
;
;Purpose:
;To create query for iug_iri2012.db
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
pro iug_create_query_iri2012,jmag,lat,lon,yyyy,mm,dd,ltut,atime,height
  openw,unit,'/tmp/iug_iri2012_query.sql',/get_lun ; create query file
  printf,unit,'select * from iug_iri2012 where jmag=',strtrim(string(jmag),1),' and lat=',strtrim(string(lat),1),' and lon=',strtrim(string(lon),1),' and yyyy=',strtrim(string(yyyy),1),' and mm=',strtrim(string(mm),1),' and dd=',strtrim(string(dd),1),' and ltut=',strtrim(string(ltut),1),' and atime=',strtrim(string(atime),1),' and height=',strtrim(string(height),1),";"
  free_lun, unit
end
