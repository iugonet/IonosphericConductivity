; docformat = 'IDL'

;+
;
;Name: IUG_LOAD_IRI2012_ARRAY
;
;INPUTS:
;yyyy: year
;
;Purpose:
;
;Syntax:
;
;KEYWORD PARAMETERS:
;hoge:
;
;Code: Yukinobu KOYAMA, 10/21/2013
;
;Modifications:
;
;Acknowledgment:
;
;Example:
;   iug_load_iri2012_array, yyyy=2000, mmdd=101, ltut=0, time=12,
;glat=0, glon=0, height_bottom=100, height_top=120, height_step=10, result=result
;
;-

pro iug_load_iri2012_array, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, glat=glat, glon=glon, height_bottom=height_bottom, height_top=height_top, height_step=height_step, result=result

;validate height
  if height_bottom lt 80 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height
  if height_bottom gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
;
;validate height
  if height_top lt 80 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height
  if height_top gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
;
  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1 
     height_step = 1 ; height_step=1 is just dummy to execute iri2012. 
  endelse
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;
  openw, unit, tmp_dir+'iri2012.input', /get_lun ; create input file
  printf,unit,0,glat,glon
  printf,unit,format='(i8,i8,i8,i8)',yyyy,mmdd,ltut,time
  printf,unit,0
  printf,unit,0
  printf,unit,0
  printf,unit,1
  printf,unit,height_bottom,height_top,height_step
  printf,unit,0
  printf,unit,0
  free_lun, unit

  spawn,'cd ${HOME}/models/ionospheric/iri/iri2012;./iritest < '+tmp_dir+'iri2012.input'
  spawn,"cat ${HOME}/models/ionospheric/iri/iri2012/fort.7 | awk '{if( NR>27 ) print $0}' > "+tmp_dir+"iri2012.result"

  result = fltarr(num_height,15)

  openr, unit, tmp_dir+'iri2012.result', /get_lun
  temp0='' & temp1='' & temp2='' & temp3='' & temp4='' 
  temp5='' & temp6='' & temp7='' & temp8='' & temp9='' 
  temp10='' & temp11='' & temp12='' & temp13='' & temp14=''

  for i=0L,num_height-1 do begin
     readf,unit,format='(a6,a8,a7,a6,a6,a6,a4,a4,a4,a4,a4,a4,a4,a6,a4)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14

     result[i,0]=temp0 ; alt
     result[i,1]=temp1 ; Ne/cm-3
     result[i,2]=temp2 ; Ne/NmF2
     result[i,3]=temp3 ; Tn/K
     result[i,4]=temp4 ; Ti/K
     result[i,5]=temp5 ; Te/K
     result[i,6]=temp6 ; O+
     result[i,7]=temp7 ; N+
     result[i,8]=temp8 ; H+
     result[i,9]=temp9 ; He+
     result[i,10]=temp10 ; O2+
     result[i,11]=temp11 ; NO+
     result[i,12]=temp12 ; Clust
     result[i,13]=temp13 ; TEC
     result[i,14]=temp14 ; t/%
  endfor

  free_lun, unit

end
