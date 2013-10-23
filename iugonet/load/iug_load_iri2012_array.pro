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

pro iug_load_iri2012_array, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                            glat=glat, glon=glon, $
                            height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                            result=result

;validate height
  if height_bottom lt 60 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height
  if height_bottom gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
;
;validate height
  if height_top lt 60 then begin
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
  mmdd = string(mmdd, format='(i4.4)')
  mm = strmid(mmdd, 0, 2)
  dd = strmid(mmdd, 2, 2)

  openw, unit, tmp_dir+'iri2012.input', /get_lun ; create input file
  printf, unit, 0, glat, glon
  printf, unit, format='(i8,i8,i8,i8)',yyyy, mmdd, ltut, time
  printf, unit, 0
  printf, unit, 0
  printf, unit, 0
  printf, unit, 1
  printf, unit, height_bottom, height_top, height_step
  printf, unit, 0
  printf, unit, 0
  free_lun, unit

  spawn, 'cd ${HOME}/models/ionospheric/iri/iri2012;./iritest < '+tmp_dir+'iri2012.input'
  spawn, "cat ${HOME}/models/ionospheric/iri/iri2012/fort.7 | awk '{if( NR>27 ) print $0}' > "+tmp_dir+"iri2012.result"

  result = fltarr(num_height,34)

  openr, unit, tmp_dir+'iri2012.result', /get_lun
  temp8 = '' & temp9 = '' & temp10 = '' & temp11 = '' & temp12 = '' 
  temp13 = '' & temp14 = ''& temp15 = '' & temp16 = '' & temp17 = ''
  temp18 = '' & temp19 = '' & temp20 = '' & temp21 = '' & temp22 = ''
  temp23 = '' & temp24 = '' & temp25 = '' & temp26 = '' & temp27 = ''
  temp28 = '' & temp29 = '' & temp30 = '' & temp31 = '' & temp32 = ''
  temp33 = '' 

  for i=0L,num_height-1 do begin
     readf,unit,format='(a6,a8,a7,a6,a6,a6,a4,a4,a4,a4,a4,a4,a4,a6,a4)',temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20,temp21,temp22
; To be implemented
; temp23, temp24, temp25, temp26, temp27, temp28, temp29, temp30,
; temp31, temp32, temp33

     result[i,0] = 1            ; jmag
     result[i,1] = glat         ; lat
     result[i,2] = glon         ; lon
     result[i,3] = yyyy         ; yyyy
     result[i,4] = mm           ; mm
     result[i,5] = dd           ; dd
     result[i,6] = ltut         ; ltut
     result[i,7] = time         ; atime
     result[i,8] = temp8        ; alt
     result[i,9] = temp9        ; Ne/cm-3
     result[i,10] = temp10      ; Ne/NmF2
     result[i,11] = temp11      ; Tn/K
     result[i,12] = temp12      ; Ti/K
     result[i,13] = temp13      ; Te/K
     result[i,14] = temp14      ; O+
     result[i,15] = temp15      ; N+
     result[i,16] = temp16      ; H+
     result[i,17] = temp17      ; He+
     result[i,18] = temp18      ; O2+
     result[i,19] = temp19      ; NO+
     result[i,20] = temp20      ; Clust
     result[i,21] = temp21      ; TEC
     result[i,22] = temp22      ; t/%
     result[i,23] = temp23      ; NmF2
     result[i,24] = temp24      ; NmF1
     result[i,25] = temp25      ; NmE
     result[i,26] = temp26      ; hmF2
     result[i,27] = temp27      ; hmF1
     result[i,28] = temp28      ; hmE
     result[i,29] = temp29      ; sza
     result[i,30] = temp30      ; dip
     result[i,31] = temp31      ; modip
     result[i,32] = temp32      ; rz12
     result[i,33] = temp33      ; ig12

     iug_insert_iri2012, jmag=result[i,0], lat=result[i,1], lon=result[i,2], yyyy=result[i,3], mm=result[i,4], dd=result[i,5], ltut=result[i,6], atime=result[i,7], height=result[i,8], ine=result[i,9], ner=result[i,10], tnk=result[i,11], tik=result[i,12], tek=result[i,13], io1=result[i,14], in1=result[i,15], ih1=result[i,16], ihe=result[i,17], io2=result[i,18], ino=result[i,19], icl=result[i,20], tec=result[i,21], tpe=result[i,22], NmF2=result[i,23], NmF1=result[i,24], NmE=result[i,25], hmF2=result[i,26], hmF1=result[i,27], hmE=result[i,28], sza=result[i,29], dip=result[i,30], modip=result[i,31], rz12=result[i,32], ig12=result[i,33]

  endfor

  free_lun, unit

end
