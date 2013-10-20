; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_08
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 07/04/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_08
;-
pro iug_load_ionospheric_cond_diagnostics_1_08
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;   

  a=[0,5.6E-10,7.5E-10,8.9E-10,1.0E-9,1.1E-9,1.2E-9,1.3E-9,1.4E-9,1.5E-9,1.8E-9,2.0E-9]
  b=[0,0,0,0,4.9E-10,5.4E-10,5.9E-10,6.2E-10,6.6E-10,7.2E-10,8.6E-10,9.7E-10]
  c=[0,0,5.6E-10,6.6E-10,7.6E-10,8.3E-10,8.9E-10,9.6E-10,1.0E-9,1.1E-9,1.3E-9,1.5E-9]
  d=[6.8E-10,8.3E-10,1.1E-9,1.3E-9,1.4E-9,1.6E-9,1.7E-9,1.8E-9,1.9E-9,2.1E-9,2.4E-9,2.7E-9]
  e=[2.2E-9,2.7E-9,3.6E-9,4.3E-9,4.8E-9,5.3E-9,5.7E-9,6.0E-9,6.3E-9,6.9E-9,8.2E-9,9.1E-9]
  f=[300,500,1000,1500,2000,2500,3000,3500,4000,5000,7500,10000]

  actual_n2 = fltarr(n_elements(f))       ; N2
  actual_o2 = fltarr(n_elements(f))       ; O2
  actual_o1 = fltarr(n_elements(f))       ; O
  actual_he = fltarr(n_elements(f))       ; He
  actual_h1 = fltarr(n_elements(f))       ; H
  actual_n1 = fltarr(n_elements(f))       ; N

  for i=0L,n_elements(f)-1 do begin
     iug_collision_freq1_in_reso,tn=f[i],ti=0,$
                                 nh1=1,no1=1,nn1=1,$
                                 nhe=1,no2=1,nn2=1,$
                                 fh1=fh1,fo1=fo1,fn1=fn1,$
                                 fhe=fhe,fo2=fo2,fn2=fn2
     actual_h1[i] = fh1/2.
     actual_o1[i] = fo1/2.
     actual_n1[i] = fn1/2.
     actual_he[i] = fhe/2.
     actual_o2[i] = fo2/2.
     actual_n2[i] = fn2/2.
  endfor

  set_plot, 'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08.ps', /color

  plot,f[1:11],actual_n2[1:11],xtitle="TEMPERATURES (Ti+Tn) K",ytitle="COLLISION FREQUENCY (cm^3 Hz)",xrange=[300,10000],yrange=[1E-10,1E-8],/ylog,linestyle=0,color=0,title="Charge exchange collision frequencies"
  oplot,f[*],actual_o2[*],linestyle=0,color=0
  oplot,f[*],actual_o1[*],linestyle=0,color=0
  oplot,f[*],actual_he[*],linestyle=0,color=0
  oplot,f[*],actual_h1[*],linestyle=0,color=0
  oplot,f[*],actual_n1[*],linestyle=0,color=0

  xyouts,8000,7.0E-9,"H+ - H"
  xyouts,8000,2.1E-9,"He+ - He"
  xyouts,8000,1.6E-9,"N2+ - N2" 
  xyouts,8000,1.1E-9,"O2+ - O2"
  xyouts,8000,7.6E-10,"O+ - O"
  xyouts,6400,1.4E-9,"N+ - N"
  xyouts,4000,3E-10,"  solid line - Actual   by Koyama"
  xyouts,4000,2.5E-10,"dotted line - Expected by Aeronomy pt. A"

  oplot,f[*],a[*],linestyle=1,color=0
  oplot,f[*],b[*],linestyle=1,color=0
  oplot,f[*],c[*],linestyle=1,color=0
  oplot,f[*],d[*],linestyle=1,color=0
  oplot,f[*],e[*],linestyle=1,color=0

  device, /close
  set_plot, 'x'

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08_n2.txt', /get_lun
  for i=0L,n_elements(a)-1 do begin
     if i ge 1 then begin
        printf,unit,a[i],actual_n2[i],(actual_n2[i]-a[i])/a[i]   * 100.,$
               format='(e10.2,e10.2,i4)'
     endif
  endfor
  free_lun,unit

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08_o2.txt', /get_lun
  for i=0L,n_elements(b)-1 do begin
     if i ge 4 then begin
        printf,unit,b[i],actual_o2[i],(actual_o2[i]-b[i])/b[i]   * 100.,$
               format='(e10.2,e10.2,i4)'
     endif
  endfor
  free_lun,unit

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08_o.txt', /get_lun
  for i=0L,n_elements(c)-1 do begin
     if i ge 3 then begin
        printf,unit,c[i],actual_o1[i] ,(actual_o1[i]-c[i])/c[i]   * 100.,$
               format='(e10.2,e10.2,i4)'
     endif
  endfor
  free_lun,unit

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08_he.txt', /get_lun
  for i=0L,n_elements(d)-1 do begin
     printf,unit,d[i],actual_he[i],(actual_he[i]-d[i])/d[i]   * 100.,$
            format='(e10.2,e10.2,i4)'
  endfor
  free_lun,unit

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_08_h.txt', /get_lun
  for i=0L,n_elements(e)-1 do begin
     printf,unit,e[i],actual_h1[i],(actual_h1[i]-e[i])/e[i] * 100.,$
            format='(e10.2,e10.2,i4)'
  endfor
  free_lun,unit

end
