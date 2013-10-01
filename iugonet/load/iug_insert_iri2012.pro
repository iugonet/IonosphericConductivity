; docformat = 'IDL'

;+
;
;Name:
;IUG_INSERT_IRI2012
;
;Purpose:
;To insert record iug_iri2012 in iug_iri2012.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_insert_iri2012
;-
pro iug_insert_iri2012,jmag,lat,lon,yyyy,mm,dd,ltut,atime,height,ine,ner,tn,ti,te,io,ih,ihe,io2,ino,icl,tec,t,NmF2,NmF1,NmE,hmF2,hmF1,hmE,sza,dip,modip,rz12,ig12
  openw,unit,'/tmp/iug_insert_iri2012.sql',/get_lun ; create query file
  printf,unit,'insert into iug_iri2012 values(',strtrim(string(jmag),1),',',strtrim(string(lat),1),',',strtrim(string(lon),1),',',strtrim(string(yyyy),1),',',strtrim(string(mm),1),',',strtrim(string(dd),1),',',strtrim(string(ltut),1),',',strtrim(string(atime),1),',',strtrim(string(height),1),',',strtrim(string(ine),1),',',strtrim(string(ner),1),',',strtrim(string(tn),1),',',strtrim(string(ti),1),',',strtrim(string(te),1),',',strtrim(string(io),1),',',strtrim(string(ih),1),',',strtrim(string(ihe),1),',',strtrim(string(io2),1),',',strtrim(string(ino),1),',',strtrim(string(icl),1),',',strtrim(string(tec),1),',',strtrim(string(t),1),',',strtrim(string(NmF2),1),',',strtrim(string(NmF1),1),',',strtrim(string(NmE),1),',',strtrim(string(hmF2),1),',',strtrim(string(hmF1),1),',',strtrim(string(hmE),1),',',strtrim(string(sza),1),',',strtrim(string(dip),1),',',strtrim(string(modip),1),',',strtrim(string(rz12),1),',',strtrim(string(ig12),1),');'
  free_lun, unit

  spawn,'sqlite3 iug_iri2012.db < /tmp/iug_insert_iri2012.sql'
end
