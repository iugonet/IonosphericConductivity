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

pro iug_load_iri90,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,ssn=ssn,result=result

  openw,unit,'/tmp/input_iri90.txt',/get_lun ; create input file
  printf,unit,1 ; 1: STORED IN FILE OUTPUT.IRI
  printf,unit,1 ; 1: STORED IN FILE KONSOL.IRI
  printf,unit,6 ; SELECT YOUR VARIABLE -> 6 ALTITUDE
  printf,unit,height_bottom,height_top,height_step
  printf,unit,0 ; 0: geodetic longitude and latitude 1: geomagnetic
  printf,unit,glat
  printf,unit,glon
  printf,unit,ssn ; solar sunsplot number
  printf,unit,mmdd 
  if ltut eq 0 then printf,unit,time              ; lt
  if ltut eq 1 then printf,unit,time+25.          ; lt
  printf,unit,1 ; ALL PARAMETERS
  printf,unit,'/' ; use default parameter
  printf,unit,'/' ; use default parameter
  printf,unit,'/' ; use default parameter
  printf,unit,'/' ; use default parameter
  printf,unit,0 ; 0:QUIT ANT EXIT
  free_lun, unit


  spawn,'cd ${HOME}/models/ionospheric/iri/iri90/fortran_code;rm *.IRI;./iri_test < /tmp/input_iri90.txt'
  spawn,"cat ${HOME}/models/ionospheric/iri/iri90/fortran_code/OUTPUT.IRI | awk '{if( NR>12 ) print $0}' > /tmp/tmp.txt"

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  result = fltarr(12,num_height)

  openr, unit, '/tmp/tmp.txt', /GET_LUN
  temp0='' & temp1='' & temp2='' & temp3='' & temp4='' 
  temp5='' & temp6='' & temp7='' & temp8='' & temp9='' 
  temp10='' & temp11=''

  for i=0L,num_height-1 do begin
     readf,unit,format='(a8,a9,a8,a6,a6,a6,a7,a5,a5,a5,a5,a5)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11

     result[0,i]=temp0 ; alt
     result[1,i]=temp1 ; Ne/cm-3
     result[2,i]=temp2 ; Ne/NmF2
     result[3,i]=temp3 ; TN/K
     result[4,i]=temp4 ; TI/K
     result[5,i]=temp5 ; TE/K
     result[6,i]=temp6 ; TE/TI
     result[7,i]=temp7 ; O+
     result[8,i]=temp8 ; H+
     result[9,i]=temp9 ; He+
     result[10,i]=temp10 ; O2+
     result[11,i]=temp11 ; NO+
  endfor

  free_lun, unit

end
