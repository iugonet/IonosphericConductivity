; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_05
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
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_05
;-

pro iug_load_ionospheric_cond_diagnostics_1_05

  temperature = [100,400,900,1600,2500,3600,4900]

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_1_05.ps',/color

  debye_length_ne1e2 = fltarr(n_elements(temperature))
  debye_length_ne1e4 = fltarr(n_elements(temperature))
  debye_length_ne1e6 = fltarr(n_elements(temperature))

; Ne = 1.E2
  num_e = 1.E2
  for i=0L,n_elements(temperature)-1 do begin
     debye_length_ne1e2[i] = iug_debye_length(num_e,temperature(i))
  endfor

  plot,temperature,debye_length_ne1e2,xtitle="Temperature (K)",ytitle="Debye Length (cm)",title="Temperature - Debye Length",/ylog,yrange=[1E-2,1E2],linestyle=0,color=0
  xyouts,4000,2E1,"Ne=1E2"
  xyouts,4000,2E0,"Ne=1E4"
  xyouts,4000,2E-1,"Ne=1E6"
  xyouts,1000,9,"  solid line - by Koyama"
  xyouts,1000,5,"dotted line - by Aeronomy"
; Ne = 1.E4
  num_e = 1.E4
  for i=0L,n_elements(temperature)-1 do begin
     debye_length_ne1e4[i] = iug_debye_length(num_e,temperature(i))
  endfor

  oplot,temperature,debye_length_ne1e4,linestyle=0,color=0
; Ne = 1.E6
  num_e = 1.E6
  for i=0L,n_elements(temperature)-1 do begin
     debye_length_ne1e6[i] = iug_debye_length(num_e,temperature(i))
  endfor

  oplot,temperature,debye_length_ne1e6,linestyle=0,color=0
;
; plot the data of the book
;  

; Ne = 1E2 
  book_debye_length_ne1e2 = [7,14,21,28,35,41,48]
  oplot,temperature,book_debye_length_ne1e2,linestyle=1,color=0
; Ne = 1E4
  book_debye_length_ne1e4 = [0.7,1,2,3,3.5,4,5]
  oplot,temperature,book_debye_length_ne1e4,linestyle=1,color=0
; Ne = 1E6
  book_debye_length_ne1e6 = [0.07,0.1,0.2,0.3,0.35,0.4,0.5]
  oplot,temperature,book_debye_length_ne1e6,linestyle=1,color=0

  device,/close
  set_plot,'x'

; Ne = 1.E2
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_05_ne1e2.txt',/get_lun
  for i=0L,n_elements(temperature)-1 do begin
     printf,unit,temperature(i),book_debye_length_ne1e2(i),$
            debye_length_ne1e2(i),$
            (debye_length_ne1e2(i) - book_debye_length_ne1e2(i)) $
            /book_debye_length_ne1e2(i)*100.
  endfor

  free_lun,unit
; Ne = 1.E4
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_05_ne1e4.txt',/get_lun
  for i=0L,n_elements(temperature)-1 do begin
     printf,unit,temperature(i),book_debye_length_ne1e4(i),$
            debye_length_ne1e4(i),$
            (debye_length_ne1e4(i) - book_debye_length_ne1e4(i)) $
            /book_debye_length_ne1e4(i)*100.
  endfor

  free_lun,unit
; Ne = 1.E6
  openw,unit,'/tmp/iug_load_ionospheric_cond_diagnostics_1_05_ne1e6.txt',/get_lun
  for i=0L,n_elements(temperature)-1 do begin
     printf,unit,temperature(i),book_debye_length_ne1e6(i),$
            debye_length_ne1e6(i),$
            (debye_length_ne1e6(i) - book_debye_length_ne1e6(i)) $
            /book_debye_length_ne1e6(i)*100.
  endfor

  free_lun,unit

end
