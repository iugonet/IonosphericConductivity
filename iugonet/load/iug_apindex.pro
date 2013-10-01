; docformat = 'IDL'

;+
;
;Name:
;IUG_APINDEX
;
;Purpose:
;To load AP index
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/19/2012
;
;Modifications:
;
;Acknowledgments:
;hoge
;
;EXAMPLE:
;result = iug_apindex(00,01,01,12)
;print,result
;
;-

function iug_apindex,yy,mm,dd,ut
  openr,unit,'${HOME}/models/ionospheric/iri/iri2012/apf107.dat',/GET_LUN
  for i=0L,19631-1 do begin
     readf,unit,format='(a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a5,a5,a5)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15
     if temp0 eq yy && temp1 eq mm && temp2 eq dd then begin
        if ut/3 eq 0 then begin
           free_lun,unit
           return,long(temp3)
        endif else if ut/3 eq 1 then begin
           free_lun,unit
           return,long(temp4)
        endif else if ut/3 eq 2 then begin
           free_lun,unit
           return,long(temp4)
        endif else if ut/3 eq 3 then begin
           free_lun,unit
           return,long(temp5)
        endif else if ut/3 eq 4 then begin
           free_lun,unit
           return,long(temp6)
        endif else if ut/3 eq 5 then begin
           free_lun,unit
           return,long(temp7)
        endif else if ut/3 eq 6 then begin
           free_lun,unit
           return,long(temp8)
        endif else if ut/3 eq 7 then begin
           free_lun,unit
           return,long(temp9)
        endif else begin
           return,0
        endelse
     endif
  endfor
  free_lun,unit

end
