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
pro iug_create_query_ionospheric_cond_map,height_bottom=height_bottom, heigit_top=height_top, height_step=height_step, resolution=resolution, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm

;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

;
  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height =1
  endelse

  height_array=fltarr(num_height)
  
  for i=0L,num_height-1 do begin
     height_array(i)=height_bottom+height_step*i
  endfor
;
  glat_array=fltarr(180/resolution+1)
  glon_array=fltarr(360/resolution+1)

  for i=0L,n_elements(glat_array)-1 do begin
     glat_array[i]=-90.+i*resolution
  endfor

  for i=0L,n_elements(glon_array)-1 do begin
     glon_array[i]=-180.+i*resolution
  endfor
;
  openw, unit, tmp_dir+'ionospheric_cond_map_query.sql', /get_lun ; create query file

  printf,unit,'.output '+tmp_dir+'ionospheric_cond_map.result'
  printf,unit,'.separator ","'

  for i=0L,n_elements(glat_array)-1  do begin
     for j=0L,n_elements(glon_array)-1 do begin
        for k=0L,num_height-1 do begin
           printf,unit,'select * from ionospheric_cond where height='+strtrim(string(height_array(k)),1)+' and glat='+strtrim(string(glat_array[i]),1)+' and glon='+strtrim(string(glon_array[j]),1)+' and yyyy='+strtrim(string(yyyy),1)+' and mmdd='+strtrim(string(mmdd),1)+' and ltut='+strtrim(string(ltut),1)+' and atime='+strtrim(string(time),1)+' and algorithm='+strtrim(string(algorithm),1)+";"
        endfor
     endfor
  endfor

  free_lun, unit
end
