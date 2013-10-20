; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_03a
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 06/02/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_03a
;-

pro iug_load_ionospheric_cond_diagnostics_1_03a

;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

   m_p = 1.6726231E-27 ; (kg)   
   m_e = 9.1093897E-31 ; (kg)
; alpha0 is from table 9.10 (10^{-24} cm^3)
  alpha0_n2  = 1.76E-24
  alpha0_o2  = 1.59E-24
  alpha0_h2  = 0.82E-24
  alpha0_o   = 0.79E-24
  alpha0_h   = 0.667E-24
  alpha0_he  = 0.21E-24
  alpha0_n   = 1.10E-24
  alpha0_no  = 1.74E-24
  alpha0_co  = 1.97E-24
  alpha0_co2 = 2.63E-24
  alpha0_n2o = 3.00E-24
  alpha0_nh3 = 2.22E-24
  alpha0_so2 = 3.89E-24
; molecular mass
  mass_he = double(4.       * (m_p+m_e))
  mass_o  = double(16.      * (m_p+m_e))
  mass_n2 = double(14. * 2. * (m_p+m_e))
  mass_o2 = double(16. * 2. * (m_p+m_e))
  mass_ar = double(40.      * (m_p+m_e))
  mass_h  = double(1.       * (m_p+m_e))
  mass_n  = double(14.      * (m_p+m_e))
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

; O+ - *
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

; N+ - *
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

; H+ - * 
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

; He+ - *
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

; O2+ - *
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

; NO+ - *
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

;
  yyyy=2000
  mmdd=101
  height_bottom=117.85 ; decided the height as Te=300 K 
  height_top=117.85    ;
  height_step=1
  time=0
  glat=0
  glon=0

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse 

  result_msis=fltarr(11,num_height)
  iug_load_nrlmsise00, yyyy=yyyy, mmdd=mmdd, height_bottom=height_bottom,height_top=height_top, height_step=height_step,time=time,glat=glat,glon=glon,result=result_msis
  
; te=300 case
  num_he=result_msis[2,0] 
  num_o =result_msis[3,0] 
  num_n2=result_msis[4,0] 
  num_o2=result_msis[5,0]
  num_ar=result_msis[6,0]
  num_h =result_msis[7,0]
;
  num_o_p=1 & num_n_p=1
  num_h_p_=1 & num_he_p=1
  num_o2_p=1 & num_no_p=1

  actual_no_p_air = iug_collision_freq_i_1_sub(1,1,1)
  actual_no_p_o   = iug_collision_freq_i_1_sub(num_o,alpha0_o,m_no_p_o)
;
  actual_o2_p_n2  = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_o2_p_n2)
  actual_o2_p_o2  = iug_collision_freq_i_1_sub(num_o2,alpha0_o2,m_o2_p_o2)
  actual_o2_p_o   = iug_collision_freq_i_1_sub(num_o,alpha0_o,m_o2_p_o)
;
;  actual_n2_p_n2  = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_n2_p_n2)
;  actual_n2_p_o2  = iug_collision_freq_i_1_sub(num_o2,alpha0_o2,m_n2_p_o2)
;  actual_n2_p_o   = iug_collision_freq_i_1_sub(num_o,alpha0_o,m_n2_p_o)
;
  actual_o_p_n2   = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_o_p_n2)
  actual_o_p_o2   = iug_collision_freq_i_1_sub(num_o2,alpha0_o2,m_o_p_o2)
  actual_o_p_o    = iug_collision_freq_i_1_sub(num_o,alpha0_o,m_o_p_o)
  actual_o_p_he   = iug_collision_freq_i_1_sub(num_he,alpha0_he,m_o_p_he)
;
  actual_n_p_n2   = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_n_p_n2)
;
  actual_h_p_h    = iug_collision_freq_i_1_sub(num_h,alpha0_h,m_h_p_h)
  actual_h_p_he   = iug_collision_freq_i_1_sub(num_he,alpha0_he,m_h_p_he)
  actual_h_p_n2   = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_h_p_n2)
;
  actual_he_p_he  = iug_collision_freq_i_1_sub(num_he,alpha0_he,m_he_p_he)
  actual_he_p_o   = iug_collision_freq_i_1_sub(num_o,alpha0_o,m_he_p_o)
  actual_he_p_n2  = iug_collision_freq_i_1_sub(num_n2,alpha0_n2,m_he_p_n2)
  actual_he_p_h   = iug_collision_freq_i_1_sub(num_h,alpha0_h,m_he_p_h)

;,num_he=num_he,num_o=num_o,num_n2=num_n2,$
;                             num_o2=num_o2,num_ar=num_ar,num_h=num_h,$
;                             num_n=num_n,num_nh3=num_nh3,$
;                             num_o_p=num_o_p,num_n_p=num_n_p,$
;                             num_h_p=num_h_p,num_he_p=num_he_p,$
;                             num_o2_p=num_o2_p,num_no_p=num_no_p,$

  print,"num_h=",num_h


;
; expected (Hz)
;
  expected_no_p_air = 7.5E-10 
  expected_no_p_o   = 6.0E-10
;
  expected_o2_p_n2  = 7.6E-10
  expected_o2_p_o2  = 9.9E-10
  expected_o2_p_o   = 5.9E-10
;
  expected_n2_p_n2  = 14.1E-10
  expected_n2_p_o2  = 7.2E-10
  expected_n2_p_o   = 7.2E-10
;
  expected_o_p_n2   = 9.2E-10
  expected_o_p_o2   = 10.2E-10
  expected_o_p_o    = 9.1E-10
  expected_o_p_he   = 4.8E-10
;
  expected_n_p_n2   = 11.4E-10
;
  expected_h_p_h    = 30.0E-10
  expected_h_p_he   = 13.3E-10
  expected_h_p_n2   = 35.1E-10
;
  expected_he_p_he  = 8.3E-10
  expected_he_p_o   = 12.8E-10
  expected_he_p_n2  = 18.4E-10
  expected_he_p_h   = 23.8E-10
;
;
;
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03a.txt', /get_lun

  printf,unit,expected_no_p_air,actual_no_p_air,(actual_no_p_air-expected_no_p_air)/expected_no_p_air * 100., expected_no_p_air/actual_no_p_air,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_no_p_o,actual_no_p_o,(actual_no_p_o-expected_no_p_o)/expected_no_p_o * 100.,expected_no_p_o/actual_no_p_o,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit
;
  printf,unit,expected_o2_p_n2,actual_o2_p_n2,(actual_o2_p_n2-expected_o2_p_n2)/expected_o2_p_n2 * 100.,expected_o2_p_n2/actual_o2_p_n2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_o2_p_o2,actual_o2_p_o2,(actual_o2_p_o2-expected_o2_p_o2)/expected_o2_p_o2 * 100.,expected_o2_p_o2/actual_o2_p_o2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_o2_p_o,actual_o2_p_o,(actual_o2_p_o-expected_o2_p_o)/expected_o2_p_o * 100.,expected_o2_p_o/actual_o2_p_o,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit
;
;  printf,unit,expected_n2_p_n2,actual_n2_p_n2,(actual_n2_p_n2-expected_n2_p_n2)/expected_n2_p_n2 * 100.,format='(e10.2,e10.2,i4)'
;  printf,unit,expected_n2_p_o2,actual_n2_p_o2,(actual_n2_p_o2-expected_n2_p_o2)/expected_n2_p_o2 * 100.,format='(e10.2,e10.2,i4)'
;  printf,unit,expected_n2_p_o,actual_n2_p_o,(actual_n2_p_o-expected_n2_p_o)/expected_n2_p_o * 100.,format='(e10.2,e10.2,i4)'
;  printf,unit
;
  printf,unit,expected_o_p_n2,actual_o_p_n2,(actual_o_p_n2-expected_o_p_n2)/expected_o_p_n2 * 100.,expected_o_p_n2/actual_o_p_n2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_o_p_o2,actual_o_p_o2,(actual_o_p_o2-expected_o_p_o2)/expected_o_p_o2 * 100.,expected_o_p_o2/actual_o_p_o2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_o_p_o,actual_o_p_o,(actual_o_p_o-expected_o_p_o)/expected_o_p_o * 100.,expected_o_p_o/actual_o_p_o,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_o_p_he,actual_o_p_he,(actual_o_p_he-expected_o_p_he)/expected_o_p_he * 100.,expected_o_p_he/actual_o_p_he,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit
;
  printf,unit,expected_n_p_n2,actual_n_p_n2,(actual_n_p_n2-expected_n_p_n2)/expected_n_p_n2 * 100.,expected_n_p_n2/actual_n_p_n2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit
;
  printf,unit,expected_h_p_h,actual_h_p_h,(actual_h_p_h-expected_h_p_h)/expected_h_p_h * 100.,expected_h_p_h/actual_h_p_h,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_h_p_he,actual_h_p_he,(actual_h_p_he-expected_he_p_he)/expected_h_p_he * 100.,expected_h_p_he/actual_he_p_he,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_h_p_n2,actual_h_p_n2,(actual_h_p_n2-expected_h_p_n2)/expected_h_p_n2 * 100.,expected_h_p_n2/actual_h_p_n2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit
;
  printf,unit,expected_he_p_he,actual_he_p_he,(actual_he_p_he-expected_he_p_he)/expected_he_p_he * 100.,expected_he_p_he/actual_he_p_he,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_he_p_o,actual_he_p_o,(actual_he_p_o-expected_he_p_o)/expected_he_p_o * 100.,expected_he_p_o/actual_he_p_o,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_he_p_n2,actual_he_p_n2,(actual_he_p_n2-expected_he_p_n2)/expected_he_p_n2 * 100.,expected_he_p_n2/actual_he_p_n2,format='(e10.2,e10.2,i4,e10.2)'
  printf,unit,expected_he_p_h,actual_he_p_h,(actual_he_p_h-expected_he_p_h)/expected_he_p_h * 100.,expected_he_p_h/actual_he_p_h,format='(e10.2,e10.2,i4,e10.2)'
;
  free_lun,unit

end
