; docformat = 'IDL'

;+
;
;Name:
;IUG_CREATE_QUERY_IONOSPHERIC_COND
;
;Purpose:
;To create query for ionospheric_cond.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_create_query_ionospheric_cond,1,2000,0,0,100
;-

pro iug_create_query_ionospheric_cond, yyyy=yyyy, mmdd=mmdd, ltut=ltut, atime=atime, $
                                       height=height, glat=glat, glon=glon, algorithm=algorithm
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;       
  openw, unit, tmp_dir+'ionospheric_cond.sql',/get_lun ; create query file

  printf, unit, '.output '+tmp_dir+'ionospheric_cond.result'
  printf, unit, '.separator ","'

  printf, unit, 'select * from ionospheric_cond where height='+strtrim(string(height),1)+' and glat='+strtrim(string(glat),1)+' and glon='+strtrim(string(glon),1)+' and yyyy='+strtrim(string(yyyy),1)+' and mmdd='+strtrim(string(mmdd),1)+' and ltut='+strtrim(string(ltut),1)+' and atime='+strtrim(string(atime),1)+' and algorithm='+strtrim(string(algorithm),1)+";"
  free_lun, unit

end
