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
  if height lt 80 then begin
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
     result = fltarr(26)

     openr, unit, tmp_dir+'iri2012.result', /get_lun
     temp0 = '' & temp1 = '' & temp2 = '' & temp3 = '' & temp4 = '' 
     temp5 = '' & temp6='' & temp7 = '' & temp8 = '' & temp9 = '' 
     temp10 = '' & temp11 = '' & temp12 = '' & temp13 = '' & temp14 = ''
     temp15 = '' & temp16 = '' & temp17 = '' & temp18 = '' & temp19 = '' & temp20 = ''
     temp21 = '' & temp22 = '' & temp23 = '' & temp24 = '' & temp25 = ''
     
     readf,unit,format='(a6,a8,a7,a6,a6,a6,a4,a4,a4,a4,a4,a4,a4,a6,a4)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14

     result[0] = temp0          ; alt
     result[1] = temp1          ; Ne/cm-3
     result[2] = temp2          ; Ne/NmF2
     result[3] = temp3          ; Tn/K
     result[4] = temp4          ; Ti/K
     result[5] = temp5          ; Te/K
     result[6] = temp6          ; O+
     result[7] = temp7          ; N+
     result[8] = temp8          ; H+
     result[9] = temp9          ; He+
     result[10] = temp10        ; O2+
     result[11] = temp11        ; NO+
     result[12] = temp12        ; Clust
     result[13] = temp13        ; TEC
     result[14] = temp14        ; t/%
     result[15] = temp15        ; NmF2
     result[16] = temp16        ; NmF1
     result[17] = temp17        ; NmE
     result[18] = temp18        ; hmF2
     result[19] = temp19        ; hmF1
     result[20] = temp20        ; hmE
     result[21] = temp21        ; sza
     result[22] = temp22        ; dip
     result[23] = temp23        ; modip
     result[24] = temp24        ; rz12
     result[25] = temp25        ; ig12

     free_lun, unit

     iug_insert_iri2012, jmag=1, lat=glat, lon=glon, yyyy=yyyy, mm=mm, dd=dd, ltut=ltut, atime=time, height=result[0], ine=result[1], ner=result[2], tnk=result[3], tik=result[4], tek=result[5], io1=result[6], in1=result[7], ih1=result[8], ihe=result[9], io2=result[10], ino=result[11], icl=result[12], tec=result[13], tpe=result[14], NmF2=result[15], NmF1=result[16], NmE=result[17], hmF2=result[18], hmF1=result[19], hmE=result[20], sza=result[21], dip=result[22], modip=result[23], rz12=result[24], ig12=result[25]

  endif else begin
     openr, unit, tmp_dir+'iri2012.result', /get_lun
     array = fltarr(15)
     readf, unit, array

     temp0 = array(0)
     temp1 = array(1)
     temp2 = array(2)
     temp3 = array(3)
     temp4 = array(4)
     temp5 = array(5)
     temp6 = array(6)
     temp7 = array(7)
     temp8 = array(8)
     temp9 = array(9)
     temp10 = array(10)
     temp11 = array(11)
     temp12 = array(12)
     temp13 = array(13)
     temp14 = array(14)

     free_lun, unit
  endelse

end
