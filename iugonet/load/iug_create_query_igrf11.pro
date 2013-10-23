; docformat = 'IDL'

;+
;
;Name:
;IUG_CREATE_QUERY_IGRF11
;
;Purpose:
;To create query for igrf11.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_create_query_igrf11,1,2000,0,0,100
;-

pro iug_create_query_igrf11, yyyy=yyyy, glat=glat, glon=glon, height=height, coordinate_system=coordinate_system 

;  
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

  openw, unit, tmp_dir+'igrf11.sql',/get_lun ; create query file

  printf, unit, '.output '+tmp_dir+'igrf11.result'
  printf, unit, '.separator ","'

  printf, unit, 'select * from igrf11 where coordinate_system='+strtrim(string(coordinate_system),1)+' and yyyy='+strtrim(string(yyyy),1)+' and glat='+strtrim(string(glat),1)+' and glon='+strtrim(string(glon),1)+' and height='+strtrim(string(height),1)+";"
  free_lun, unit

end
