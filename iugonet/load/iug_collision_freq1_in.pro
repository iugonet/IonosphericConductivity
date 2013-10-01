; docformat = 'IDL'

;+
;
;Name:
;IUG_COLLISION_FREQ1_IN
;
;Purpose:
;To calulate ionic collision frequency
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
;  print, iug_collision_freq1_in(1,1,1,1,1,1)
;-
function iug_collision_freq1_in,num_he,num_o,num_n2,num_o2,$
                                num_ar,num_h,num_n,num_nh3,$
                                num_o_p,num_n_p,num_h_p,$
                               num_he_p,num_o2_p,num_no_p

   m_p = 1.6726231E-27 ; (kg)   
   m_e = 9.1093897E-31 ; (kg)

; alpha0 is from table 9.10 (10^{-24} cm^3)
  alpha0_n2  = 1.76
  alpha0_o2  = 1.59
  alpha0_h2  = 0.82
  alpha0_o   = 0.79
  alpha0_h   = 0.667
  alpha0_he  = 0.21
  alpha0_n   = 1.10
  alpha0_no  = 1.74
  alpha0_co  = 1.97
  alpha0_co2 = 2.63
  alpha0_n2o = 3.00
  alpha0_nh3 = 2.22
  alpha0_so2 = 3.89
;
; Chemical Physics Letters, 
; Volume 234, Issues 1-3,
; Mar. 1995, Pages 113-118
;
  alpha0_ar = 1.49

 ; molecular mass
  mass_he = double(4.       * (m_p+m_e))
  mass_o  = double(16.      * (m_p+m_e))
  mass_n2 = double(14. * 2. * (m_p+m_e))
  mass_o2 = double(16. * 2. * (m_p+m_e))
  mass_ar = double(40.      * (m_p+m_e))
  mass_h  = double(1.       * (m_p+m_e))
  mass_n  = double(14.      * (m_p+m_e))
  mass_nh3= double(17.      * (m_p+m_e))

; ionic mass
  mass_o_p  = double((16.       ) * (m_p+m_e) - m_e)
  mass_n_p  = double((14.       ) * (m_p+m_e) - m_e)
  mass_h_p  = double((1.        ) * (m_p+m_e) - m_e)
  mass_he_p = double((4.        ) * (m_p+m_e) - m_e)
  mass_o2_p = double((16. * 2.)   * (m_p+m_e) - m_e)
  mass_no_p = double((14. + 16.)  * (m_p+m_e) - m_e) 

; m_a (amu)
  amu=1.66053886E-27 ; 1 (amu)=1.66053886E-27 (kg)

  nu_in_o_p  = 0. &   nu_in_n_p  = 0.
  nu_in_h_p  = 0. &   nu_in_he_p = 0.
  nu_in_o2_p = 0. &   nu_in_no_p = 0.

; O+
  if num_o_p ne 0 then begin
     m_o_p_he  = (mass_o_p * mass_he) $
                        /(mass_o_p + mass_he) / amu
     m_o_p_o   = (mass_o_p * mass_o) $
                        /(mass_o_p + mass_o) / amu
     m_o_p_n2  = (mass_o_p * mass_n2) $
                        /(mass_o_p + mass_n2) / amu
     m_o_p_o2  = (mass_o_p * mass_o2) $
                        /(mass_o_p + mass_o2) / amu
     m_o_p_ar  = (mass_o_p * mass_ar) $
                        /(mass_o_p + mass_ar) / amu
     m_o_p_h   = (mass_o_p * mass_h) $
                        /(mass_o_p + mass_h) / amu
     m_o_p_n   = (mass_o_p * mass_n) $
                        /(mass_o_p + mass_n) / amu
     m_o_p_nh3 = (mass_o_p * mass_nh3) $
                        /(mass_o_p + mass_nh3) / amu

     nu_in_o_p    = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_o_p_he)$
                               +num_o *sqrt(alpha0_o /m_o_p_o)$ 
                               +num_n2*sqrt(alpha0_n2/m_o_p_n2)$
                               +num_o2*sqrt(alpha0_o2/m_o_p_o2)$
                               +num_ar*sqrt(alpha0_ar/m_o_p_ar)$
                               +num_h*sqrt(alpha0_h/m_o_p_h)$
                               +num_n*sqrt(alpha0_n/m_o_p_n)$
                               +num_nh3*sqrt(alpha0_nh3/m_o_p_nh3))

  endif

; N+
  if num_n_p ne 0 then begin
     m_n_p_he  = (mass_n_p * mass_he) $
                        /(mass_n_p + mass_he) / amu
     m_n_p_o   = (mass_n_p * mass_o) $
                        /(mass_n_p + mass_o) / amu
     m_n_p_n2  = (mass_n_p * mass_n2) $
                        /(mass_n_p + mass_n2) / amu
     m_n_p_o2  = (mass_n_p * mass_o2) $
                        /(mass_n_p + mass_o2) / amu
     m_n_p_ar  = (mass_n_p * mass_ar) $
                        /(mass_n_p + mass_ar) / amu
     m_n_p_h   = (mass_n_p * mass_h) $
                        /(mass_n_p + mass_h) / amu
     m_n_p_n   = (mass_n_p * mass_n) $
                        /(mass_n_p + mass_n) / amu
     m_n_p_nh3 = (mass_n_p * mass_nh3) $
                        /(mass_n_p + mass_nh3) / amu

     nu_in_n_p    = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_n_p_he)$
                               +num_o*sqrt(alpha0_o /m_n_p_o )$
                               +num_n2*sqrt(alpha0_n2/m_n_p_n2)$
                               +num_o2*sqrt(alpha0_o2/m_n_p_o2)$
                               +num_ar*sqrt(alpha0_ar/m_n_p_ar)$
                               +num_h*sqrt(alpha0_h/m_n_p_h)$
                               +num_n*sqrt(alpha0_n/m_n_p_n)$
                               +num_nh3*sqrt(alpha0_nh3/m_n_p_nh3) )
  endif

; H+
  if num_h_p ne 0 then begin
     m_h_p_he  = (mass_h_p * mass_he) $
                        /(mass_h_p + mass_he) / amu
     m_h_p_o   = (mass_h_p * mass_o) $
                        /(mass_h_p + mass_o) / amu
     m_h_p_n2  = (mass_h_p * mass_n2) $
                        /(mass_h_p + mass_n2) / amu
     m_h_p_o2  = (mass_h_p * mass_o2) $
                        /(mass_h_p + mass_o2) / amu
     m_h_p_ar  = (mass_h_p * mass_ar) $
                        /(mass_h_p + mass_ar) / amu
     m_h_p_h   = (mass_h_p * mass_h) $
                        /(mass_h_p + mass_h) / amu
     m_h_p_n   = (mass_h_p * mass_n) $
                        /(mass_h_p + mass_n) / amu
     m_h_p_nh3 = (mass_h_p * mass_nh3) $
                        /(mass_h_p + mass_nh3) / amu

     nu_in_h_p    = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_h_p_he)$
                               +num_o *sqrt(alpha0_o /m_h_p_o )$ 
                               +num_n2*sqrt(alpha0_n2/m_h_p_n2)$
                               +num_o2*sqrt(alpha0_o2/m_h_p_o2)$
                               +num_ar*sqrt(alpha0_ar/m_h_p_ar)$
                               +num_h*sqrt(alpha0_h/m_h_p_h)$
                               +num_n*sqrt(alpha0_n/m_h_p_n)$
                               +num_nh3*sqrt(alpha0_nh3/m_h_p_nh3) )
  endif

; He+
  if num_he_p ne 0 then begin
     m_he_p_he  = (mass_he_p * mass_he) $
                        /(mass_he_p + mass_he) / amu
     m_he_p_o   = (mass_he_p * mass_o) $
                        /(mass_he_p + mass_o) / amu
     m_he_p_n2  = (mass_he_p * mass_n2) $
                        /(mass_he_p + mass_n2) / amu
     m_he_p_o2  = (mass_he_p * mass_o2) $
                        /(mass_he_p + mass_o2) / amu
     m_he_p_ar  = (mass_he_p * mass_ar) $
                        /(mass_he_p + mass_ar) / amu
     m_he_p_h   = (mass_he_p * mass_h) $
                        /(mass_he_p + mass_h) / amu
     m_he_p_n   = (mass_he_p * mass_n) $
                        /(mass_he_p + mass_n) / amu
     m_he_p_nh3 = (mass_he_p * mass_nh3) $
                        /(mass_he_p + mass_nh3) / amu

     nu_in_he_p    = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_he_p_he)$
                                +num_o *sqrt(alpha0_o /m_he_p_o)$
                                +num_n2*sqrt(alpha0_n2/m_he_p_n2)$
                                +num_o2*sqrt(alpha0_o2/m_he_p_o2)$
                                +num_ar*sqrt(alpha0_ar/m_he_p_ar)$
                                +num_h*sqrt(alpha0_h/m_he_p_h)$
                                +num_n*sqrt(alpha0_n/m_he_p_n)$
                                +num_nh3*sqrt(alpha0_nh3/m_he_p_nh3) )
  endif

; O2+
  if num_o2_p ne 0 then begin
     m_o2_p_he  = (mass_o2_p * mass_he) $
                        /(mass_o2_p + mass_he) / amu
     m_o2_p_o   =  (mass_o2_p * mass_o) $
                        /(mass_o2_p + mass_o) / amu
     m_o2_p_n2  =  (mass_o2_p * mass_n2) $
                        /(mass_o2_p + mass_n2) / amu
     m_o2_p_o2  =  (mass_o2_p * mass_o2) $
                        /(mass_o2_p + mass_o2) / amu
     m_o2_p_ar  = (mass_o2_p * mass_ar) $
                        /(mass_o2_p + mass_ar) / amu
     m_o2_p_h   = (mass_o2_p * mass_h) $
                        /(mass_o2_p + mass_h) / amu
     m_o2_p_n   = (mass_o2_p * mass_n) $
                        /(mass_o2_p + mass_n) / amu
     m_o2_p_nh3 = (mass_o2_p * mass_nh3) $
                        /(mass_o2_p + mass_nh3) / amu

     nu_in_o2_p   = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_o2_p_he)$
                               +num_o *sqrt(alpha0_o /m_o2_p_o )$
                               +num_n2*sqrt(alpha0_n2/m_o2_p_n2)$
                               +num_o2*sqrt(alpha0_o2/m_o2_p_o2)$
                               +num_ar*sqrt(alpha0_ar/m_o2_p_ar)$
                               +num_h*sqrt(alpha0_h/m_o2_p_h)$
                               +num_n*sqrt(alpha0_n/m_o2_p_n)$
                               +num_nh3*sqrt(alpha0_nh3/m_o2_p_nh3) )

  endif

; NO+
  if num_no_p ne 0 then begin
     m_no_p_he  = (mass_no_p * mass_he) $
                        /(mass_no_p + mass_he) / amu
     m_no_p_o   = (mass_no_p * mass_o) $
                        /(mass_no_p + mass_o) / amu
     m_no_p_n2  = (mass_no_p * mass_n2) $
                        /(mass_no_p + mass_n2) / amu
     m_no_p_o2  = (mass_no_p * mass_o2) $
                        /(mass_no_p + mass_o2) / amu
     m_no_p_ar  = (mass_no_p * mass_ar) $
                        /(mass_no_p + mass_ar) / amu
     m_no_p_h   = (mass_no_p * mass_h) $
                        /(mass_no_p + mass_h) / amu
     m_no_p_n   = (mass_no_p * mass_n) $
                        /(mass_no_p + mass_n) / amu
     m_no_p_nh3 = (mass_no_p * mass_nh3) $
                        /(mass_no_p + mass_nh3) / amu

     nu_in_no_p   = 2.6E-9 * ( num_he*sqrt(alpha0_he/m_no_p_he)$
                               +num_o *sqrt(alpha0_o /m_no_p_o)$
                               +num_n2*sqrt(alpha0_n2/m_no_p_n2)$
                               +num_o2*sqrt(alpha0_o2/m_no_p_o2)$
                               +num_ar*sqrt(alpha0_ar/m_no_p_ar)$
                               +num_h*sqrt(alpha0_h/m_no_p_h)$
                               +num_n*sqrt(alpha0_n/m_no_p_n)$
                               +num_nh3*sqrt(alpha0_nh3/m_no_p_nh3) )

  endif
;
  
  return, ( 16.*num_o_p*nu_in_o_p $
          + 14.*num_n_p*nu_in_n_p $
          + 1. *num_h_p*nu_in_h_p $
          + 4. *num_he_p*nu_in_he_p $
          + 32.*num_o2_p*nu_in_o2_p $
          + 30.*num_no_p*nu_in_no_p ) $
          / (  16.*num_o_p $
             + 14 *num_n_p $
             + 1. *num_h_p $
             + 4. *num_he_p $
             + 32.*num_o2_p $
             + 30.*num_no_p )

end
