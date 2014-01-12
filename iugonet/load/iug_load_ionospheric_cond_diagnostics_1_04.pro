; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_04
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 05/01/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_04
;-
pro iug_load_ionospheric_cond_diagnostics_1_04
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

  num_e = [1.0E2,2.5E2,5.0E2,7.5E2,1.0E3,2.5E3,5.0E3,7.5E3,1.0E4,2.5E4,5.0E4,$
           7.5E4,1.0E5,2.5E5,5.0E5,7.5E5,1.0E6,2.5E6,5.0E6]
  temperature = [600,800,1000,1200,1400,1600,1800,2000]
  result = fltarr(n_elements(num_e),n_elements(temperature))

  for i=0L,n_elements(num_e)-1 do begin
     for j=0L,n_elements(temperature)-1 do begin
        result[i,j] = iug_collision_freq1_ei(num_e[i],temperature[j])
     endfor
  endfor

  set_plot, 'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_04.eps', /color, /encapsulated

  plot, temperature[*], result[0,*], xtitle="Temperature (K)", ytitle="Collision Frequency (Hz)", $
        yrange=[1E-2,1E5],xrange=[600,2000], /ylog, linestyle=0, color=0, $
        title="ELECTRON COLLISION FREQUENCIES WITH POSITIVE IONS"
  for i=0L,n_elements(num_e)-1 do begin
     oplot,temperature[*],result[i,*],linestyle=0,color=0
  endfor
  xyouts, 1100, 2E5, "From top to bottom, ne=1.0E2 to ne=5.0E6",color=0
  xyouts, 1100, 7E4, "  solid line - Actual    by Koyama",color=0
  xyouts, 1100, 4E4, "dotted line - Expected by Aeronomy pt. A",color=0

;
; 
;
  expected = [[4.1E-1,2.7E-1,2.0E-1,1.5E-1,1.2E-1,1.0E-1,8.7E-2,7.5E-2],$
              [1.0E0,6.7E-1,4.9E-1,3.8E-1,3.0E-1,2.5E-1,2.1E-1,1.8E-1],$
              [2.0E0,1.3E0,9.5E-1,7.4E-1,5.9E-1,4.9E-1,4.2E-1,3.6E-1],$
              [2.9E0,1.9E0,1.4E0,1.1E0,8.8E-1,7.3E-1,6.2E-1,5.3E-1],$
              [3.8E0,2.6E0,1.9E0,1.4E0,1.2E0,9.6E-1,8.2E-1,7.0E-1],$
              [1.2E1,6.2E0,4.5E0,3.5E0,2.9E0,2.3E0,2.0E0,1.7E0],$
              [1.8E1,1.2E1,8.9E0,6.9E0,5.5E0,4.6E0,3.9E0,3.3E0],$
              [2.7E1,1.8E1,1.3E1,1.0E1,8.2E0,6.8E0,5.8E0,5.0E0],$
              [3.5E1,2.4E1,1.7E1,1.3E1,1.1E1,9.0E0,7.6E0,6.6E0],$
              [8.6E1,5.7E1,4.2E1,3.3E1,2.6E1,2.2E1,1.8E1,1.6E1],$
              [1.7E2,1.1E2,8.2E1,6.4E1,5.1E1,4.3E1,3.6E1,3.1E1],$
              [2.5E2,1.7E2,1.2E2,9.4E1,7.6E1,6.3E1,5.3E1,4.6E1],$
              [3.3E2,2.2E2,1.6E2,1.2E2,1.0E2,8.3E1,7.1E1,6.1E1],$
              [7.9E2,5.3E2,3.9E2,3.0E2,2.4E2,2.0E2,1.7E2,1.5E2],$
              [1.5E3,1.0E3,7.6E2,5.9E2,4.7E2,3.9E2,3.3E2,2.9E2],$
              [2.3E3,1.5E3,1.1E3,8.7E2,7.0E2,5.8E2,4.9E2,4.3E2],$
              [3.0E3,2.0E3,1.5E3,1.1E3,9.2E2,7.7E2,6.5E2,5.6E2],$
              [7.2E3,4.8E3,3.5E3,2.8E3,2.2E3,1.9E3,1.6E3,1.4E3],$
              [1.4E4,9.4E3,6.9E3,5.4E3,4.3E3,3.6E3,3.4E3,2.6E3]]

  for i=0L,n_elements(num_e)-1 do begin
     oplot, temperature[*], result[i,*], linestyle=1, color=0
  endfor

  device, /close
  set_plot, 'x'
;
;
;
  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_04.txt', /get_lun
  for i=0L,n_elements(num_e)-1 do begin
     for j=0L,n_elements(temperature)-1 do begin
        printf, unit, expected[j,i], result[i,j], (expected[j,i]-result[i,j])/result[i,j]*100., format='(e10.2,e10.2,i4)'
     endfor
     printf, unit, ""
  endfor

  free_lun, unit

end
