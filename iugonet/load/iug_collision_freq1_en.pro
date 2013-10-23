; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ1_EN
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 05/07/2012
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  print,iug_collision_freq1_en(,,)
;
;-

function iug_collision_freq1_en, t_e, num_n2, num_o2, num_o, num_h, num_he

  nu_e_n2 = (2.33E-11)*num_n2*(1-(1.2E-4)*t_e)*t_e
  nu_e_o2 = (1.8E-10) *num_o2*(1+(3.6E-2)*sqrt(t_e))*sqrt(t_e)
  nu_e_o  = (8.2E-10) *num_o*sqrt(t_e)
  nu_e_h  = (4.5E-9)  *num_h*(1-(1.35E-4)*t_e)*sqrt(t_e)
  nu_e_he = (4.6E-10) *num_he*sqrt(t_e)

  return, nu_e_n2+nu_e_o2+nu_e_o+nu_e_h+nu_e_he

end
