; docformat = 'IDL'

;+
;
;Name:
;IUG_F107
;
;Purpose:
;To load F10.7 index
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/19/2012
;
;Acknowledgment:
;
;EXAMPLE:
;  print,iug_f107(00,01,01)
;-

function iug_f107, yy, mm, dd

  openr, unit, '${HOME}/models/ionospheric/iri/iri2012/apf107.dat', /get_lun

  result = 0 

  for i=0L,19631-1 do begin
     readf,unit,format='(a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a3,a5,a5,a5)',temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15
     if temp0 eq yy && temp1 eq mm && temp2 eq dd then begin
        result = temp13
        break
     endif
  endfor

  free_lun, unit

  return, result

end
