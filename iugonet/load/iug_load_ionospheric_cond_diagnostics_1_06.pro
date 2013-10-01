; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_06
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 06/05/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_06
;-

pro iug_load_ionospheric_cond_diagnostics_1_06

  debye_length = [0.1,0.5,1.0,2.0,5.0,10.0,20.0,50.0,100.0]
  m_e = 9.1093897E-28 ; (g)    
  m_p = 1.6726231E-24 ; (g)    
  mu = (double(m_e)*double(m_p))/(double(m_e)+double(m_p))

;
  set_plot,'ps'
  device,filename='iug_load_ionospheric_cond_diagnostics_1_06.ps',/color

  coulomb_logarithm1en2 = fltarr(n_elements(debye_length))
  coulomb_logarithm5en2 = fltarr(n_elements(debye_length))
  coulomb_logarithm1en1 = fltarr(n_elements(debye_length))
  coulomb_logarithm5en1 = fltarr(n_elements(debye_length))
  coulomb_logarithm1e0 = fltarr(n_elements(debye_length))
  coulomb_logarithm5e0 = fltarr(n_elements(debye_length))
  coulomb_logarithm1e1 = fltarr(n_elements(debye_length))
  coulomb_logarithm5e1 = fltarr(n_elements(debye_length))
  coulomb_logarithm1e2 = fltarr(n_elements(debye_length))

; epsilon=1E-2
  epsilon=1.E-2
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm1en2[i] = iug_coulomb_logarithm(debye_length(i), $
                                                      velocity,mu)
  endfor

  plot,debye_length,coulomb_logarithm1en2,xtitle="Debye Length (cm)",ytitle="Coulomb Logarithm",title="Values of Coulomb Logarithm",/ylog,yrange=[1E0,1E2],linestyle=0,color=0
  xyouts,20,60,"From top to bottom,"
  xyouts,20,50,"epsilon=1E-2, 5E-2, 1E-1,5E-1,1E0,5E0,1E1,5E1,1E2"
  xyouts,20,3,"  solid line - by Koyama"
  xyouts,20,2.5,"dotted line - by Aeronomy pt. A"

; epsilon=5.E-2
  epsilon=5.E-2
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm5en2[i] = iug_coulomb_logarithm(debye_length(i), $
                                                      velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm5en2,linestyle=0,color=0
; epsilon=1.E-1
  epsilon=1.E-1
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm1en1[i] = iug_coulomb_logarithm(debye_length(i), $
                                                      velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm1en1,linestyle=0,color=0
; epsilon=5.E-1
  epsilon=5.E-1
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm5en1[i] = iug_coulomb_logarithm(debye_length(i), $
                                                      velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm5en1,linestyle=0,color=0
; epsilon=1.E0
  epsilon=1.E0
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm1e0[i] = iug_coulomb_logarithm(debye_length(i), $
                                                      velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm1e0,linestyle=0,color=0
; epsilon=5.E0
  epsilon=5.E0
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm5e0[i] = iug_coulomb_logarithm(debye_length(i), $
                                                     velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm5e0,linestyle=0,color=0
; epsilon=1.E1
  epsilon=1.E1
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm1e1[i] = iug_coulomb_logarithm(debye_length(i), $
                                                     velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm1e1,linestyle=0,color=0
; epsilon=5.E1
  epsilon=5.E1
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm5e1[i] = iug_coulomb_logarithm(debye_length(i), $
                                                     velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm5e1,linestyle=0,color=0
; epsilon=1.E2
  epsilon=1.E2
  for i=0L,n_elements(debye_length)-1 do begin
     velocity=sqrt(2.*1.60217733E-19*epsilon/(mu*1.E-3) ) ; in mksa 
     velocity=velocity*1.E2 ; in cgs
     coulomb_logarithm1e2[i] = iug_coulomb_logarithm(debye_length(i), $
                                                     velocity,mu)
  endfor

  oplot,debye_length,coulomb_logarithm1e2,linestyle=0,color=0

;
; plot the data of the book
;  

; epsilon=1.E-2
  book_coulomb_logarithm1en2 = [9.5,11.1,11.8,12.5,13.5,14.1,14.8,15.8,16.4]
  oplot,debye_length,book_coulomb_logarithm1en2,linestyle=1,color=0
; epsilon=5.E-2
  book_coulomb_logarithm5en2 = [11.1,12.8,13.5,14.1,15.1,15.8,16.4,17.4,18.1]
  oplot,debye_length,book_coulomb_logarithm5en2,linestyle=1,color=0
; epsilon=1.E-1
  book_coulomb_logarithm1en1 = [11.8,13.5,14.1,14.8,15.8,16.4,17.1,18.1,18.8]
  oplot,debye_length,book_coulomb_logarithm1en2,linestyle=1,color=0
; epsilon=5.E-1
  book_coulomb_logarithm5en1 = [13.5,15.1,15.8,16.4,17.4,18.1,18.8,19.7,20.4]
  oplot,debye_length,book_coulomb_logarithm5en1,linestyle=1,color=0
; epsilon=1.E0
  book_coulomb_logarithm1e0 = [14.1,15.8,16.4,17.1,18.1,18.8,19.4,20.4,21.1]
  oplot,debye_length,book_coulomb_logarithm1e0,linestyle=1,color=0
; epsilon=5.E0
  book_coulomb_logarithm5e0 = [15.8,17.4,18.1,18.8,19.7,20.4,21.1,22.0,22.7]
  oplot,debye_length,book_coulomb_logarithm5e0,linestyle=1,color=0
; epsilon=1.E1
  book_coulomb_logarithm1e1 = [16.4,18.1,18.8,19.4,20.4,21.1,21.7,22.7,23.4]
  oplot,debye_length,book_coulomb_logarithm1e1,linestyle=1,color=0
; epsilon=5.E1
  book_coulomb_logarithm5e1 = [18.1,19.7,20.4,21.1,22.0,22.7,23.4,24.3,25.0]
  oplot,debye_length,book_coulomb_logarithm5e1,linestyle=1,color=0
; epsilon=1.E2
  book_coulomb_logarithm1e2 = [18.8,20.4,21.0,21.7,22.6,23.4,24.0,24.9,25.7]
  oplot,debye_length,book_coulomb_logarithm1e2,linestyle=1,color=0

  device,/close
  set_plot,'x'

; epsilon=1.E-2
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon1en2.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm1en2(i),$
            coulomb_logarithm1en2(i),$
            (coulomb_logarithm1en2(i) - book_coulomb_logarithm1en2(i)) $
            /book_coulomb_logarithm1en2(i)*100.
  endfor

  free_lun,unit
; epsilon=5E-2
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon5en2.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm5en2(i),$
            coulomb_logarithm5en2(i),$
            (coulomb_logarithm5en2(i) - book_coulomb_logarithm5en2(i)) $
            /book_coulomb_logarithm5en2(i)*100.
  endfor

  free_lun,unit
; epsilon=1.E-1
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon1en1.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm1en1(i),$
            coulomb_logarithm1en1(i),$
            (coulomb_logarithm1en1(i) - book_coulomb_logarithm1en1(i)) $
            /book_coulomb_logarithm1en1(i)*100.
  endfor

  free_lun,unit
; epsilon=5.E-1
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon5en1.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm5en1(i),$
            coulomb_logarithm5en1(i),$
            (coulomb_logarithm5en1(i) - book_coulomb_logarithm5en1(i)) $
            /book_coulomb_logarithm5en1(i)*100.
  endfor

  free_lun,unit
; epsilon=1.E0
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon1e0.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm1e0(i),$
            coulomb_logarithm1e0(i),$
            (coulomb_logarithm1e0(i) - book_coulomb_logarithm1e0(i)) $
            /book_coulomb_logarithm1e0(i)*100.
  endfor

  free_lun,unit
; epsilon=5.E0
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon5e0.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i), book_coulomb_logarithm5e0(i),$
            coulomb_logarithm5e0(i),$
            (coulomb_logarithm5e0(i) - book_coulomb_logarithm5e0(i)) $
            /book_coulomb_logarithm5e0(i)*100.
  endfor

  free_lun,unit
; epsilon=1.E1
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon1e1.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin           
     printf,unit,debye_length(i), book_coulomb_logarithm1e1(i),$
            coulomb_logarithm1e1(i),$
            (coulomb_logarithm1e1(i) - book_coulomb_logarithm1e1(i)) $
            /book_coulomb_logarithm1e1(i)*100.
  endfor

  free_lun,unit
; epsilon=5.E1
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon5e1.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm5e1(i),$
            coulomb_logarithm5e1(i),$
            (coulomb_logarithm5e1(i) - book_coulomb_logarithm5e1(i)) $
            /book_coulomb_logarithm5e1(i)*100.
  endfor

  free_lun,unit
; epsilon=1.E2
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_06_epsilon1e2.txt',/get_lun
  for i=0L,n_elements(debye_length)-1 do begin
     printf,unit,debye_length(i),book_coulomb_logarithm1e2(i),$
            coulomb_logarithm1e2(i),$
            (coulomb_logarithm1e2(i) - book_coulomb_logarithm1e2(i)) $
            /book_coulomb_logarithm1e2(i)*100.
  endfor

  free_lun,unit

end
