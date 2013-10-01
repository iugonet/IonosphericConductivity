; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ1_EI
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
;print,iug_collision_freq1_ei()
;
;-
function iug_collision_freq1_ei,ni,te

  k_b = 1.380658E-16  ; Boltzman Constant (erg deg-1)  
  m_e = 9.1093897E-28 ; (g)
  m_p = 1.6726231E-24 ; (g) 
  zi=1. ; charge state. see page 232, Aeronomy pt. A -- Academic Press, 1973.
                                ; This value can take -1, 0, 1. In
                                ; this case, the ionized gas is dealt
                                ; with. Then zi^2 is
                                ; calculated. That's why zi=1 is hardcoded.
  e_charge=4.8032068E-10 ; (esu)

  debye_length = iug_debye_length(ni,te)
  mu=(double(m_e)*double(2.*m_p))/(double(m_e)+double(2.*m_p)) 
; 1./2. m v^2 = 3./2.k_b T_e
  velocity = sqrt( 3.* k_b * te / mu)
  coulomb_logarithm = iug_coulomb_logarithm(debye_length,velocity,mu)

  return,4.*((2.*!dpi)^(1./2.)) * 1.^2. *(e_charge^4.)*coulomb_logarithm $
         /( 3.*m_e^(1./2.)*(k_b*te)^(3./2.) )*ni

end
