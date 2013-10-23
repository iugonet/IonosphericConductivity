; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IRI90
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;
;Code:
;Yukinobu KOYAMA, 5/18/2012
;
;Modifications:
;
;Acknowledgment
;
;Example:
;  iug_load_iri90,mmdd=101,ltut=0,time=12,glat=0,glon=0,height_bottom=100,height_top=400,height_step=10,ssn=15,result=result
;
;-

pro iug_load_iri90, mmdd=mmdd, ltut=ltut, time=time, $
                    glat=glat, glon=glon, $
                    height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                    ssn=ssn,result=result
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;
  openw, unit, tmp_dir+'input_iri90.txt', /get_lun ; create input file
  printf, unit, 1 ; 1: STORED IN FILE OUTPUT.IRI
  printf, unit, 1 ; 1: STORED IN FILE KONSOL.IRI
  printf, unit, 6 ; SELECT YOUR VARIABLE -> 6 ALTITUDE
  printf, unit, height_bottom, height_top, height_step
  printf, unit, 0 ; 0: geodetic longitude and latitude 1: geomagnetic
  printf, unit, glat
  printf, unit, glon
  printf, unit, ssn ; solar sunsplot number
  printf, unit, mmdd 
  if ltut eq 0 then printf, unit, time              ; lt
  if ltut eq 1 then printf, unit, time+25.          ; lt
  printf, unit, 1 ; ALL PARAMETERS
  printf, unit, '/' ; use default parameter
  printf, unit, '/' ; use default parameter
  printf, unit, '/' ; use default parameter
  printf, unit, '/' ; use default parameter
  printf, unit, 0 ; 0:QUIT ANT EXIT
  free_lun, unit

  spawn, 'cd ${HOME}/models/ionospheric/iri/iri90/fortran_code;rm *.IRI;./iri_test < '+tmp_dir+'input_iri90.txt'
  spawn, "cat ${HOME}/models/ionospheric/iri/iri90/fortran_code/OUTPUT.IRI | awk '{if( NR>12 ) print $0}' > "+tmp_dir+"tmp.txt"

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  result = fltarr(num_height,12)

  openr, unit, tmp_dir+'tmp.txt', /get_lun
  temp0='' & temp1='' & temp2='' & temp3='' & temp4='' 
  temp5='' & temp6='' & temp7='' & temp8='' & temp9='' 
  temp10='' & temp11=''

  for i=0L,num_height-1 do begin
     readf,unit,format='(a8,a9,a8,a6,a6,a6,a7,a5,a5,a5,a5,a5)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11

     result[i,0] = temp0          ; alt
     result[i,1] = temp1          ; Ne/cm-3
     result[i,2] = temp2          ; Ne/NmF2
     result[i,3] = temp3          ; TN/K
     result[i,4] = temp4          ; TI/K
     result[i,5] = temp5          ; TE/K
     result[i,6] = temp6          ; TE/TI
     result[i,7] = temp7          ; O+
     result[i,8] = temp8          ; H+
     result[i,9] = temp9          ; He+
     result[i,10] = temp10        ; O2+
     result[i,11] = temp11        ; NO+
  endfor

  free_lun, unit

end
