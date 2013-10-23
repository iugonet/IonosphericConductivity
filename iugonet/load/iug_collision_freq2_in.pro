; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ2_IN
;
;Purpose:
;To calulate ionic collision frequency
;
;KEYWORD PARAMETERS:
;r_i: test
;
;Code:
;Yukinobu KOYAMA, 04/19/2012
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  print, iug_collision_freq2_in(1,1,1,1,1,1,1)
;-

function iug_collision_freq2_in, r_i, num_n2, num_o2, num_o, no_plus, o2_plus, o_plus

; definition of physical constants 
  m_p = 1.6726231E-27                ; (kg)
  
  nu_in_no_plus = ( 3.4*num_n2*r_i^(-0.16) + 3.4*num_o2*r_i^(-0.16) $
                    + 1.9*num_o*r_i^(-0.19) ) * 1.E-16
  nu_in_o2_plus = ( 3.3*num_n2*r_i^(-0.17) + 6.1*num_o2*r_i^(0.37) $
                    + 1.8*num_o*r_i^(-0.19) ) * 1.E-16
  nu_in_o_plus  = ( 5.4*num_n2*r_i^(-0.20) + 7.0*num_o2*r_i^(0.05) $
                    + 8.9*num_o*r_i^0.5 ) * 1.E-16

  m_i_no_plus = 30. * m_p
  m_i_o2_plus = 32. * m_p
  m_i_o_plus  = 16. * m_p 

  nu_in_o_plus = 0. & o_plus=0.

  nu_in = ( m_i_no_plus * no_plus * nu_in_no_plus $
           + m_i_o2_plus* o2_plus * nu_in_o2_plus $
           + m_i_o_plus * o_plus  * nu_in_o_plus ) $
          /( m_i_no_plus * no_plus $
             + m_i_o2_plus * o2_plus $
             + m_i_o_plus * o_plus )

  return, nu_in

end
