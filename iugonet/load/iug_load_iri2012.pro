; docformat = 'IDL'

;+
;
;Name: IUG_LOAD_IRI2012
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
;Code: Yukinobu KOYAMA, 4/25/2012
;
;Modifications:
;Code: Yukinobu KOYAMA, 10/21/2013
;
;Acknowledgment:
;
;Example:
;   iug_load_iri2012, yyyy=2000, mmdd=101, ltut=0, time=12, glat=0,
;glon=0, height=100, result=result
;
;-

pro iug_load_iri2012, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, glat=glat, glon=glon, height=height, result=result

;validate height
  if height lt 60 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height
  if height gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;
  mmdd = string(mmdd,format='(i4.4)')
  mm = strmid(mmdd,0,2)
  dd = strmid(mmdd,2,2)
  
  iug_create_query_iri2012, jmag=1, lat=glat, lon=glon, yyyy=yyyy, mm=mm, dd=dd, ltut=ltut, atime=time, height=height
  spawn, 'sqlite3 ${UDASPLUS_HOME}/iugonet/load/iri2012.db < '+tmp_dir+'iri2012.sql'
  query_result = file_info(tmp_dir+'iri2012.result')

  if query_result.size eq 0 then begin ; calculate by using model
;
     openw, unit, tmp_dir+'iri2012.input', /get_lun ; create input file
     printf,unit,0,glat,glon
     printf,unit,format='(i8,i8,i8,i8)',yyyy,mmdd,ltut,time
     printf,unit,0
     printf,unit,0
     printf,unit,0
     printf,unit,1
     printf,unit,height,height,1 ; height_step=1 is just dummy to execute iri2012
     printf,unit,0
     printf,unit,0
     free_lun, unit
     
     spawn,'cd ${HOME}/models/ionospheric/iri/iri2012;./iritest < '+tmp_dir+'iri2012.input'
     spawn,"cat ${HOME}/models/ionospheric/iri/iri2012/fort.7 | awk '{if( NR>27 ) print $0}' > "+tmp_dir+"iri2012.result"
     result = fltarr(34)

     openr, unit, tmp_dir+'iri2012.result', /get_lun
     temp8 = '' & temp9 = '' & temp10 = '' & temp11 = '' & temp12 = '' 
     temp13 = '' & temp14 = ''& temp15 = '' & temp16 = '' & temp17 = ''
     temp18 = '' & temp19 = '' & temp20 = '' & temp21 = '' & temp22 = ''
     temp23 = '' & temp24 = '' & temp25 = '' & temp26 = '' & temp27 = ''
     temp28 = '' & temp29 = '' & temp30 = '' & temp31 = '' & temp32 = ''
     temp33 = '' 
     
     readf,unit,format='(a6,a8,a7,a6,a6,a6,a4,a4,a4,a4,a4,a4,a4,a6,a4)',temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20,temp21,temp22
; To be implemented
; temp23, temp24, temp25, temp26, temp27, temp28, temp29, temp30,
; temp31, temp32, temp33

     result[0] = 1              ; jmag
     result[1] = glat           ; lat
     result[2] = glon           ; lon
     result[3] = yyyy           ; yyyy
     result[4] = mm             ; mm
     result[5] = dd             ; dd
     result[6] = ltut           ; ltut
     result[7] = time           ; atime
     result[8] = temp8          ; alt
     result[9] = temp9          ; Ne/cm-3
     result[10] = temp10        ; Ne/NmF2
     result[11] = temp11        ; Tn/K
     result[12] = temp12        ; Ti/K
     result[13] = temp13        ; Te/K
     result[14] = temp14        ; O+
     result[15] = temp15        ; N+
     result[16] = temp16        ; H+
     result[17] = temp17        ; He+
     result[18] = temp18        ; O2+
     result[19] = temp19        ; NO+
     result[20] = temp20        ; Clust
     result[21] = temp21        ; TEC
     result[22] = temp22        ; t/%
     result[23] = temp23        ; NmF2
     result[24] = temp24        ; NmF1
     result[25] = temp25        ; NmE
     result[26] = temp26        ; hmF2
     result[27] = temp27        ; hmF1
     result[28] = temp28        ; hmE
     result[29] = temp29        ; sza
     result[30] = temp30        ; dip
     result[31] = temp31        ; modip
     result[32] = temp32        ; rz12
     result[33] = temp33        ; ig12

     free_lun, unit

     iug_insert_iri2012, jmag=result[0], lat=result[1], lon=result[2], yyyy=result[3], mm=result[4], dd=result[5], ltut=result[6], atime=result[7], height=result[8], ine=result[9], ner=result[10], tnk=result[11], tik=result[12], tek=result[13], io1=result[14], in1=result[15], ih1=result[16], ihe=result[17], io2=result[18], ino=result[19], icl=result[20], tec=result[21], tpe=result[22], NmF2=result[23], NmF1=result[24], NmE=result[25], hmF2=result[26], hmF1=result[27], hmE=result[28], sza=result[29], dip=result[30], modip=result[31], rz12=result[32], ig12=result[33]

  endif else begin
     openr, unit, tmp_dir+'iri2012.result', /get_lun
     result = fltarr(34)
     readf, unit, result

     free_lun, unit
  endelse

end
