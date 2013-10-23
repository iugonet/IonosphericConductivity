; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ2_EI_PARA
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 11/18/2011
;
;Modifications:
;Yukinobu KOYAMA, 04/19/2012
;
;Acknowledgment:
;
;EXAMPLE:
;print,iug_collision_freq2_ei_para(1,1)
;
;-

function iug_collision_freq2_ei_para, ni, te

  coulomb_logarithm = 16.33+0.5*alog(te^3./ni)
  return, (1.84E-6)*coulomb_logarithm*ni*te^(-3./2.)

end

