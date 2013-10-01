; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ2_EN_PERP
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/26/2012
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  print,iug_collision_freq2_en_perp(120,10,1,1)
;
;-
function iug_collision_freq2_en_perp,r_e,n2,o2,o

  return,(7.2*n2*r_e^0.95 + 5.2*o2*r_e^0.79 + 1.9*o*r_e^0.85)*1.E-15

end
