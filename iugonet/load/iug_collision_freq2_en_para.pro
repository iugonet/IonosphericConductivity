; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ2_EN_PARA
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 11/18/2011
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  print,iug_collision_freq2_en_para(120,10,1,1)
;
;-
function iug_collision_freq2_en_para,r_e,num_n2,num_o2,num_o

  return,(4.6*num_n2*r_e^0.95 +4.3*num_o2*r_e^0.79 +1.5*num_o*r_e^0.85)*1.E-15

end
