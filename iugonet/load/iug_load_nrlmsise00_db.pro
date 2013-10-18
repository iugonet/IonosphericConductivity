; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_NRLMSISE00
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/25/2012
;
;Modifications:
;
;Example:
;  iug_load_nrlmsise00,height_bottom=100,height_top=120,height_step=10,time=12,glat=0,
;glon=0, result=result
;  print,result
;-

pro iug_load_nrlmsise00, yyyy=yyyy, mmdd=mmdd, height_bottom=height_bottom, height_top=height_top, height_step=height_step,time=time, glat=glat, glon=glon,result=result

  yyyy=string(yyyy,format='(i4)')
  mmdd=string(mmdd,format='(i4.4)')
  yy=strmid(yyyy,2,2)
  mm=strmid(mmdd,0,2)
  dd=strmid(mmdd,2,2)
  yyyy_mm_dd=yyyy+"-"+mm+"-"+dd

  t_struc = time_struct(yyyy_mm_dd)

  openw,unit,'/tmp/input_nrlmsise00.txt',/get_lun ; create parameter file
  printf,unit,height_bottom
  printf,unit,height_top
  printf,unit,height_step
  printf,unit,t_struc.doy   ; IDAY
  printf,unit,time+glon/15l ; XLST (See header of nrlmsise00_sub.for)
  printf,unit,time*3600l    ; UT (SEC)
  printf,unit,glat 
  printf,unit,glon
  printf,unit,iug_f107a(yy,mm,dd)   ; F107A
  printf,unit,iug_f107(yy,mm,dd)    ; F107
  printf,unit,iug_apindex(yy,mm,dd,time) ; AP
  free_lun, unit

  spawn,'cd ${HOME}/models/atmospheric/msis/nrlmsise00;./nrlmsise00_driver_iugonet.out < /tmp/input_nrlmsise00.txt > output_nrlmsise00.txt'

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  result = fltarr(num_height,11)
  
  openr, unit, '${HOME}/models/atmospheric/msis/nrlmsise00/output_nrlmsise00.txt', /GET_LUN
  temp0='' & temp1='' & temp2='' & temp3='' & temp4='' 
  temp5='' & temp6='' & temp7='' & temp8='' & temp9='' 
  temp10=''

  for i=0L,num_height-1 do begin
     readf,unit,format='(a12,a12,a12,a12,a12,a12,a12,a12,a12,a12,a12,a12,a12,a12,a12)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10
     result[i,0]=temp0 ; TINF
     result[i,1]=temp1 ; TG
     result[i,2]=temp2 ; HE
     result[i,3]=temp3 ; O
     result[i,4]=temp4 ; N2
     result[i,5]=temp5 ; O2
     result[i,6]=temp6 ; AR
     result[i,7]=temp7 ; H
     result[i,8]=temp8 ; N
     result[i,9]=temp9 ; ANM O
     result[i,10]=temp10 ; RHO
  endfor

  free_lun, unit

end

