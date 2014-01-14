; docformat = 'IDL'

;+
;
;Name:
;IUG_INSERT_IRI2012
;
;Purpose:
;To insert record iri2012 in iri2012.db
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
pro iug_insert_iri2012,jmag=jmag,lat=lat,lon=lon,yyyy=yyyy,mm=mm,dd=dd,ltut=ltut,atime=atime,height=height,ine=ine,ner=ner,tnk=tnk,tik=tik,tek=tek,io1=io1,in1=in1,ih1=ih1,ihe=ihe,io2=io2,ino=ino,icl=icl,tec=tec,tpe=tpe,NmF2=NmF2,NmF1=NmF1,NmE=NmE,hmF2=hmF2,hmF1=hmF1,hmE=hmE,sza=sza,dip=dip,modip=modip,rz12=rz12,ig12=ig12
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

  openw, unit, tmp_dir+'iri2012_insert.sql', /get_lun ; create query file

  printf, unit, 'insert into iri2012 values('+strtrim(string(jmag),1)+','+strtrim(string(lat),1)+','+strtrim(string(lon),1)+','+strtrim(string(yyyy),1)+','+strtrim(string(mm),1)+','+strtrim(string(dd),1)+','+strtrim(string(ltut),1)+','+strtrim(string(atime),1)+','+strtrim(string(height),1)+','+strtrim(string(ine),1)+','+strtrim(string(ner),1)+','+strtrim(string(tnk),1)+','+strtrim(string(tik),1)+','+strtrim(string(tek),1)+','+strtrim(string(io1),1)+','+strtrim(string(in1),1)+','+strtrim(string(ih1),1)+','+strtrim(string(ihe),1)+','+strtrim(string(io2),1)+','+strtrim(string(ino),1)+','+strtrim(string(icl),1)+','+strtrim(string(tec),1)+','+strtrim(string(tpe),1)+','+strtrim(string(NmF2),1)+','+strtrim(string(NmF1),1)+','+strtrim(string(NmE),1)+','+strtrim(string(hmF2),1)+','+strtrim(string(hmF1),1)+','+strtrim(string(hmE),1)+','+strtrim(string(sza),1)+','+strtrim(string(dip),1)+','+strtrim(string(modip),1)+','+strtrim(string(rz12),1)+','+strtrim(string(ig12),1)+');'

  free_lun, unit

  spawn,'sqlite3 ${UDASEXTRA_HOME}/iugonet/load/iri2012.db < '+tmp_dir+'iri2012_insert.sql'

end
