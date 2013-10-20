; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_03
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
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_03
;-

pro iug_load_ionospheric_cond_diagnostics_1_03
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

  num_e = [1E2,2.5E2,5E2,7.5E2,1E3,2.5E3,5.0E3,7.5E3,1E4,2.5E4,5.0E4,7.5E4,1E5,2.5E5,5.0E5,7.5E5,1E6,2.5E6,5.0E6]

  set_plot,'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03.ps',/color

  nu_ei600 = fltarr(n_elements(num_e))
  nu_ei800 = fltarr(n_elements(num_e))
  nu_ei1000 = fltarr(n_elements(num_e))
  nu_ei1200 = fltarr(n_elements(num_e))
  nu_ei1400 = fltarr(n_elements(num_e))
  nu_ei1600 = fltarr(n_elements(num_e))
  nu_ei1800 = fltarr(n_elements(num_e))
  nu_ei2000 = fltarr(n_elements(num_e))

; Te=600 (K)
  te = 600
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei600[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  plot,num_e,nu_ei600,xtitle="Number of Electrons",ytitle="Frequency (Hz)",title="Electron Collision Frequencies with Positive Ions",/xlog,xrange=[1E2,1E7],/ylog,yrange=[1E-1,1E5],linestyle=0,color=0
  xyouts,3E2,1E4,'  solid line - by Koyama'
  xyouts,3E2,3E3,'dotted line - by Aeronomy pt. A'
  xyouts,7E4,1E1,'From top to bottom,'
  xyouts,7E4,5E0,'Te=  600,  800, 1000, 1200, '
  xyouts,7E4,2.5E0,'    1400, 1600, 1800, 2000 K'
; Te=800 (K)
  te = 800
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei800[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei800,linestyle=0,color=0
; Te=1000 (K)
  te = 1000
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei1000[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei1000,linestyle=0,color=0
; Te=1200 (K)
  te = 1200
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei1200[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei1200,linestyle=0,color=0
; Te=1400 (K)
  te = 1400
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei1400[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei1400,linestyle=0,color=0
; Te=1600 (K)
  te = 1600
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei1600[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei1600,linestyle=0,color=0
; Te=1800 (K)
  te = 1800
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei1800[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei1800,linestyle=0,color=0
; Te=2000 (K)
  te = 2000
  for i=0L,n_elements(num_e)-1 do begin
     nu_ei2000[i] = iug_collision_freq1_ei(num_e[i],te)
  endfor

  oplot,num_e,nu_ei2000,linestyle=0,color=0

;
; plot the data of the book
;  

; Te = 600 (k)
  book_nu_ei600 = [4.1E-1,1.0,2.0,2.9,3.8,1.2E1,1.8E1, 2.7E1,3.5E1,8.6E1,1.7E2,2.5E2,3.3E2,7.9E2,1.5E3,2.3E3,3.0E3,7.2E3,1.4E4] 
  oplot,num_e,book_nu_ei600,linestyle=1,color=0
; Te = 800 (K)
  book_nu_ei800 = [2.7E-1,6.7E-1,1.3,1.9,2.6,6.2,1.2E1,1.8E1,2.4E1,5.7E1,1.1E2,1.7E2,2.2E2,5.3E2,1.0E3,1.5E3,2.0E3,4.8E3,9.4E3]
  oplot,num_e,book_nu_ei800,linestyle=1,color=0
; Te = 1000 (K)
  book_nu_ei1000 = [2.0E-1,4.9E-1,9.5E-1,1.4,1.9,4.5,8.9,1.3E1,1.7E1,4.2E1,8.2E1,1.2E2,1.6E2,3.9E2,7.6E2,1.1E3,1.5E3,3.5E3,6.9E3]
  oplot,num_e,book_nu_ei1000,linestyle=1,color=0
; Te=1200 (K)
  book_nu_ei1200 = [1.5E-1,3.8E-1,7.4E-1,1.1,1.4,3.5,6.9,1.0E1,1.3E1,3.3E1,6.4E1,9.4E1,1.2E2,3.0E2,5.9E2,8.7E2,1.1E3,2.8E3,5.4E3]
  oplot,num_e,book_nu_ei1200,linestyle=1,color=0
; Te=1400 (K)
  book_nu_ei1400 = [1.2E-1,3.0E-1,5.9E-1,8.8E-1,1.2,2.9,5.5,8.2,1.1E1,2.6E1,5.1E1,7.6E1,1.0E2,2.4E2,4.7E2,7.0E2,9.2E2,2.2E3,4.3E3]
  oplot,num_e,book_nu_ei1400,linestyle=1,color=0
; Te=1600 (K)
  book_nu_ei1600 = [1.0E-1,2.5E-1,4.9E-1,7.3E-1,9.6E-1,2.3,4.6,6.8,9.0,2.2E1,4.3E1,6.3E1,8.3E1,2.0E2,3.9E2,5.8E2,7.7E2,1.9E3,3.6E3]
  oplot,num_e,book_nu_ei1600,linestyle=1,color=0
; Te=1800 (K)
  book_nu_ei1800 = [8.7E-2,2.1E-1,4.2E-1,6.2E-1,8.2E-1,2.0,3.9,5.8,7.6,1.8E1,3.6E1,5.3E1,7.1E1,1.7E2,3.3E2,4.9E2,6.5E2,1.6E3,3.4E3]
  oplot,num_e,book_nu_ei1800,linestyle=1,color=0
; Te=2000 (K)
  book_nu_ei2000 = [7.5E-2,1.8E-1,3.6E-1,5.3E-1,7.0E-1,1.7,3.3,5.0,6.6,1.6E1,3.1E1,4.6E1,6.1E1,1.5E2,2.9E2,4.3E2,5.6E2,1.4E3,2.6E3]
  oplot,num_e,book_nu_ei2000,linestyle=1,color=0

  device,/close
  set_plot,'x'

; te=600
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te0600.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei600(i),nu_ei600(i),$
            (nu_ei600(i) - book_nu_ei600(i))/book_nu_ei600(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=800
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te0800.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei800(i),nu_ei800(i),$
            (nu_ei800(i) - book_nu_ei800(i))/book_nu_ei800(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=1000
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te1000.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei1000(i),nu_ei1000(i),$
            (nu_ei1000(i) - book_nu_ei1000(i))/book_nu_ei1000(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=1200
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te1200.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei1200(i),nu_ei1200(i),$
            (nu_ei1200(i) - book_nu_ei1200(i))/book_nu_ei1200(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=1400
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te1400.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei1400(i),nu_ei1400(i),$
            (nu_ei1400(i) - book_nu_ei1400(i))/book_nu_ei1400(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=1600
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te1600.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei1600(i),nu_ei1600(i),$
            (nu_ei1600(i) - book_nu_ei1600(i))/book_nu_ei1600(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=1800
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te1800.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei1800(i),nu_ei1800(i),$
            (nu_ei1800(i) - book_nu_ei1800(i))/book_nu_ei1800(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit
; te=2000
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_03_te2000.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     printf,unit,num_e(i),book_nu_ei2000(i),nu_ei2000(i),$
            (nu_ei2000(i) - book_nu_ei2000(i))/book_nu_ei2000(i)*100., $
            format='(e10.2,e10.2,e10.2,i4)'
  endfor

  free_lun,unit

end
