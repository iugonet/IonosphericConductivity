; docformat = 'IDL'

;+
;
;-

pro iug_load_ionospheric_cond_diagnostics_1_01
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

;
; 
;
  height_bottom=100
  height_top=400
  height_step=10
  glat=0
  glon=0
  yyyy=2000
  mmdd=101
  ltut=0
  time=0
  algorithm=1

  set_plot,'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result1.eps',/color, /encapsulated

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0]/result[*,0], result[*,6], xtitle="!4r!X!L*!n/!4r!X!L0!n", ytitle="Altitude (km)",xrange=[1.E-10,1.E1], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000-01-01T00:00Z"
  oplot, result[*,1]/result[*,0], result[*,6], linestyle=0, color=6
  oplot, result[*,2]/result[*,0], result[*,6], linestyle=0, color=2

  height=[100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400]
  takeda0=[1.31E-03,6.64E-03,1.19E-02,1.08E-02,1.49E-02,3.97E-02,1.41E-01,3.23E-01,6.61E-01,1.31E+00,2.47E+00,4.39E+00,7.14E+00,1.02E+01,1.27E+01,1.45E+01,1.58E+01,1.66E+01,1.72E+01,1.76E+01,1.79E+01,1.81E+01,1.83E+01,1.84E+01,1.84E+01,1.85E+01,1.87E+01,1.89E+01,1.90E+01,1.91E+01,1.92E+01]
  takeda1=[4.71E-07,1.66E-06,3.95E-06,2.17E-06,1.11E-06,1.14E-06,1.76E-06,1.95E-06,2.13E-06,2.55E-06,3.31E-06,4.75E-06,6.17E-06,8.19E-06,1.03E-05,1.25E-05,1.46E-05,1.64E-05,1.77E-05,1.84E-05,1.84E-05,1.78E-05,1.66E-05,1.51E-05,1.33E-05,1.14E-05,9.68E-06,8.07E-06,6.66E-06,5.44E-06,4.41E-06]
  takeda2=[1.69E-05,1.80E-05,8.45E-06,1.56E-06,3.78E-07,2.16E-07,2.05E-07,1.51E-07,1.18E-07,1.08E-07,1.16E-07,1.48E-07,1.50E-07,1.58E-07,1.58E-07,1.53E-07,1.44E-07,1.31E-07,1.16E-07,9.86E-08,8.13E-08,6.49E-08,5.02E-08,3.78E-08,2.78E-08,1.99E-08,1.41E-08,9.81E-09,6.78E-09,4.64E-09,3.16E-09]

  oplot,takeda0/takeda0,height,linestyle=1,color=0
  oplot,takeda1/takeda0,height,linestyle=1,color=6
  oplot,takeda2/takeda0,height,linestyle=1,color=2
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*18.,"  solid line - by Koyama",color=0
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*17.,"dotted line - by Takeda",color=0
  xyouts,2.E0,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L0!n",color=0
  xyouts,5.E-6,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L1!n",color=6
  xyouts,5.E-8,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L2!n",color=2
  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result1.txt', /get_lun

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  print,"num_height=",num_height
  for i=0L,num_height-1 do begin
     printf,unit,height[i], $
            takeda0[i],result[i,0],(result[i,0]-takeda0[i])/takeda0[i]*1.E2, $
            takeda1[i],result[i,1],(result[i,1]-takeda1[i])/takeda1[i]*1.E2, $
            takeda2[i],result[i,2],(result[i,2]-takeda2[i])/takeda2[i]*1.E2, $
            format='(i4,e10.2,e10.2,i5,e10.2,e10.2,i5,e10.2,e10.2,i5)'
  endfor
  free_lun,unit

; Height Integrated conductivities
  result2d = iug_height_integrated_cond(result)

  s0_takeda = 3.160E6 & s1_takeda = 2.555E0 & s2_takeda = 3.939E-1
  sxx_takeda = 1.331E1 & syy_takeda = 2.557E0 & sxy_takeda = -8.989E-1

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result5.txt', /get_lun
  printf,unit,"s0=",s0_takeda,result2d[0],(result2d[0]-s0_takeda)/s0_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s1=",s1_takeda,result2d[1],(result2d[1]-s1_takeda)/s1_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s2=",s2_takeda,result2d[2],(result2d[2]-s2_takeda)/s2_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxx=",sxx_takeda,result2d[3], $
         (result2d[3]-sxx_takeda)/sxx_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'
  printf,unit,"syy=",syy_takeda,result2d[4], $
         (result2d[4]-syy_takeda)/syy_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxy=",sxy_takeda,result2d[5], $
         (result2d[5]-sxy_takeda)/sxy_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'
  
  free_lun,unit
;
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat=0
  glon=0
  yyyy=2000
  mmdd=101
  ltut=0
  time=12
  algorithm=1

  set_plot,'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result2.eps', /color, /encapsulated

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0]/result[*,0], result[*,6], xtitle="!4r!X!L*!n/!4r!X!L0!n", ytitle="Altitude (km)",xrange=[1.E-10,1.E1], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000-01-01T12:00Z"
  oplot, result[*,1]/result[*,0], result[*,6], linestyle=0, color=6
  oplot, result[*,2]/result[*,0], result[*,6], linestyle=0, color=2

  height=[100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400]
  takeda0=[7.12E-02,3.43E-01,9.69E-01,1.87E+00,2.98E+00,4.30E+00,5.84E+00,7.61E+00,9.65E+00,1.20E+01,1.46E+01,1.75E+01,2.08E+01,2.45E+01,2.86E+01,3.34E+01,3.87E+01,4.29E+01,4.44E+01,4.49E+01,4.39E+01,4.19E+01,3.92E+01,3.63E+01,3.33E+01,3.10E+01,3.04E+01,3.07E+01,3.11E+01,3.15E+01,3.19E+01]
  takeda1=[2.43E-05,1.01E-04,4.17E-04,5.14E-04,3.54E-04,2.33E-04,1.64E-04,1.22E-04,9.42E-05,7.48E-05,6.04E-05,4.67E-05,4.01E-05,3.41E-05,2.94E-05,2.63E-05,2.42E-05,2.20E-05,1.95E-05,1.92E-05,1.89E-05,1.85E-05,1.80E-05,1.73E-05,1.66E-05,1.58E-05,1.49E-05,1.40E-05,1.29E-05,1.19E-05,1.08E-05]
  takeda2=[8.97E-04,1.03E-03,8.49E-04,3.71E-04,1.27E-04,4.98E-05,2.32E-05,1.24E-05,7.15E-06,4.36E-06,2.74E-06,1.58E-06,1.12E-06,7.74E-07,5.47E-07,4.01E-07,3.05E-07,2.30E-07,1.70E-07,1.40E-07,1.15E-07,9.49E-08,7.81E-08,6.40E-08,5.22E-08,4.23E-08,3.40E-08,2.72E-08,2.16E-08,1.70E-08,1.32E-08]

  oplot,takeda0/takeda0,height,linestyle=1,color=0
  oplot,takeda1/takeda0,height,linestyle=1,color=6
  oplot,takeda2/takeda0,height,linestyle=1,color=2
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*18.,"  solid line - by Koyama",color=0
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*17.,"dotted line - by Takeda",color=0
  xyouts,2.E0,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L0!n",color=0
  xyouts,5.E-6,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L1!n",color=6
  xyouts,5.E-8,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L2!n",color=2

  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result2.txt', /get_lun
  num_height = (height_top-height_bottom)/height_step+1
  for i=0L,num_height-1 do begin
     printf,unit,height[i], $
            takeda0[i],result[i,0],(result[i,0]-takeda0[i])/takeda0[i]*1.E2, $
            takeda1[i],result[i,1],(result[i,1]-takeda1[i])/takeda1[i]*1.E2, $
            takeda2[i],result[i,2],(result[i,2]-takeda2[i])/takeda2[i]*1.E2, $
            format='(i4,e10.2,e10.2,i5,e10.2,e10.2,i5,e10.2,e10.2,i5)'
  endfor
  free_lun,unit

; Height Integrated conductivities
  result2d = iug_height_integrated_cond(result)

  s0_takeda = 7.211E6 & s1_takeda = 2.572E1 & s2_takeda = 2.932E1
  sxx_takeda = 1.340E2 & syy_takeda = 2.581E1 & sxy_takeda = -6.690E1

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result6.txt', /get_lun
  printf,unit,"s0=",s0_takeda,result2d[0],(result2d[0]-s0_takeda)/s0_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s1=",s1_takeda,result2d[1],(result2d[1]-s1_takeda)/s1_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s2=",s2_takeda,result2d[2],(result2d[2]-s2_takeda)/s2_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxx=",sxx_takeda,result2d[3], $
         (result2d[3]-sxx_takeda)/sxx_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'
  printf,unit,"syy=",syy_takeda,result2d[4], $
         (result2d[4]-syy_takeda)/syy_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxy=",sxy_takeda,result2d[5], $
         (result2d[5]-sxy_takeda)/sxy_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'
  
  free_lun,unit
; 
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat=0
  glon=0
  yyyy=1992
  mmdd=101
  ltut=0
  time=0
  algorithm=1

  set_plot,'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result3.eps', /color, /encapsulated

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0]/result[*,0], result[*,6], xtitle="!4r!X!L*!n/!4r!X!L0!n", ytitle="Altitude (km)",xrange=[1.E-10,1.E1], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 1992-01-01T00:00Z"
  oplot, result[*,1]/result[*,0], result[*,6], linestyle=0, color=6
  oplot, result[*,2]/result[*,0], result[*,6], linestyle=0, color=2

  height=[100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400]
  takeda0=[1.65E-03,6.94E-03,1.16E-02,1.02E-02,1.31E-02,3.32E-02,1.13E-01,2.40E-01,4.65E-01,8.82E-01,1.64E+00,2.96E+00,5.13E+00,8.22E+00,1.16E+01,1.48E+01,1.77E+01,2.01E+01,2.21E+01,2.39E+01,2.55E+01,2.70E+01,2.83E+01,2.96E+01,3.07E+01,3.16E+01,3.21E+01,3.23E+01,3.25E+01,3.26E+01,3.27E+01]
  takeda1=[5.04E-07,1.82E-06,4.13E-06,2.41E-06,1.33E-06,1.49E-06,2.48E-06,2.85E-06,3.27E-06,4.08E-06,5.47E-06,8.28E-06,1.08E-05,1.53E-05,2.02E-05,2.56E-05,3.13E-05,3.69E-05,4.17E-05,4.56E-05,4.80E-05,4.88E-05,4.81E-05,4.60E-05,4.28E-05,3.88E-05,3.44E-05,3.00E-05,2.59E-05,2.21E-05,1.87E-05]
  takeda2=[1.83E-05,1.95E-05,9.40E-06,1.89E-06,5.15E-07,3.37E-07,3.67E-07,2.98E-07,2.59E-07,2.63E-07,3.04E-07,4.40E-07,4.60E-07,5.46E-07,5.98E-07,6.33E-07,6.50E-07,6.46E-07,6.21E-07,5.78E-07,5.21E-07,4.54E-07,3.85E-07,3.17E-07,2.54E-07,1.99E-07,1.53E-07,1.16E-07,8.68E-08,6.44E-08,4.74E-08]
  oplot,takeda0/takeda0,height,linestyle=1,color=0
  oplot,takeda1/takeda0,height,linestyle=1,color=6
  oplot,takeda2/takeda0,height,linestyle=1,color=2
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*18.,"  solid line - by Koyama",color=0
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*17.,"dotted line - by Takeda",color=0
  xyouts,2.E0,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L0!n",color=0
  xyouts,5.E-6,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L1!n",color=6
  xyouts,5.E-8,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L2!n",color=2

  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result3.txt', /get_lun
  num_height = (height_top-height_bottom)/height_step+1
  for i=0L,num_height-1 do begin
     printf,unit,height[i], $
            takeda0[i],result[i,0],(result[i,0]-takeda0[i])/takeda0[i]*1.E2, $
            takeda1[i],result[i,1],(result[i,1]-takeda1[i])/takeda1[i]*1.E2, $
            takeda2[i],result[i,2],(result[i,2]-takeda2[i])/takeda2[i]*1.E2, $
            format='(i4,e10.2,e10.2,i5,e10.2,e10.2,i5,e10.2,e10.2,i5)'
  endfor
  free_lun,unit

; Height Integrated conductivities
  result2d = iug_height_integrated_cond(result)

  s0_takeda = 4.487E6 & s1_takeda = 6.596E0 & s2_takeda = 5.005E-1
  sxx_takeda = 3.640E1 & syy_takeda = 6.597E0 & sxy_takeda = -1.176E0

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result7.txt', /get_lun
  printf,unit,"s0=",s0_takeda,result2d[0],(result2d[0]-s0_takeda)/s0_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s1=",s1_takeda,result2d[1],(result2d[1]-s1_takeda)/s1_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s2=",s2_takeda,result2d[2],(result2d[2]-s2_takeda)/s2_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxx=",sxx_takeda,result2d[3], $
         (result2d[3]-sxx_takeda)/sxx_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'
  printf,unit,"syy=",syy_takeda,result2d[4], $
         (result2d[4]-syy_takeda)/syy_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxy=",sxy_takeda,result2d[5], $
         (result2d[5]-sxy_takeda)/sxy_takeda*1.E2,format='(a4,e10.2,e10.2,i5)'

  free_lun,unit
;
;
; 
  height_bottom=100
  height_top=400
  height_step=10
  glat=0
  glon=0
  yyyy=1992
  mmdd=101
  ltut=0
  time=12
  algorithm=1

  set_plot,'ps'
  device, filename=tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result4.eps', /color, /encapsulated

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0]/result[*,0], result[*,6], xtitle="!4r!X!L*!n/!4r!X!L0!n", ytitle="Altitude (km)",xrange=[1.E-10,1.E1], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 1992-01-01T12:00Z"
  oplot, result[*,1]/result[*,0], result[*,6], linestyle=0, color=6
  oplot, result[*,2]/result[*,0], result[*,6], linestyle=0, color=2
  height=[100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400]
  takeda0=[8.50E-02,3.45E-01,9.20E-01,1.75E+00,2.72E+00,3.84E+00,5.08E+00,6.46E+00,8.01E+00,9.74E+00,1.17E+01,1.38E+01,1.62E+01,1.89E+01,2.20E+01,2.55E+01,2.98E+01,3.40E+01,3.70E+01,3.90E+01,4.09E+01,4.17E+01,4.15E+01,4.07E+01,3.96E+01,3.86E+01,3.86E+01,3.91E+01,3.97E+01,4.02E+01,4.07E+01]
  takeda1=[2.56E-05,1.06E-04,4.18E-04,5.45E-04,4.02E-04,2.85E-04,2.14E-04,1.69E-04,1.37E-04,1.13E-04,9.56E-05,8.19E-05,7.10E-05,6.23E-05,5.37E-05,4.91E-05,4.75E-05,4.56E-05,4.29E-05,4.07E-05,4.16E-05,4.22E-05,4.27E-05,4.30E-05,4.30E-05,4.27E-05,4.20E-05,4.11E-05,3.98E-05,3.82E-05,3.64E-05]
  takeda2=[9.38E-04,1.07E-03,9.01E-04,4.26E-04,1.63E-04,7.28E-05,3.88E-05,2.32E-05,1.47E-05,9.70E-06,6.66E-06,4.71E-06,3.41E-06,2.52E-06,1.78E-06,1.40E-06,1.18E-06,9.82E-07,8.00E-07,6.59E-07,5.86E-07,5.17E-07,4.59E-07,4.06E-07,3.57E-07,3.12E-07,2.72E-07,2.35E-07,2.02E-07,1.72E-07,1.45E-07]
  oplot,takeda0/takeda0,height,linestyle=1,color=0
  oplot,takeda1/takeda0,height,linestyle=1,color=6
  oplot,takeda2/takeda0,height,linestyle=1,color=2
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*18.,"  solid line - by Koyama",color=0
  xyouts,1.E-5,height_bottom+(height_top-height_bottom)/20.*17.,"dotted line - by Takeda",color=0
  xyouts,2.E0,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L0!n",color=0
  xyouts,5.E-6,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L1!n",color=6
  xyouts,5.E-8,height_bottom+(height_top-height_bottom)/20.*10.,"!4r!X!L2!n",color=2

  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result4.txt', /get_lun
  num_height = (height_top-height_bottom)/height_step+1
  for i=0L,num_height-1 do begin
     printf,unit,height[i], $
            takeda0[i],result[i,0],(result[i,0]-takeda0[i])/takeda0[i]*1.E2, $
            takeda1[i],result[i,1],(result[i,1]-takeda1[i])/takeda1[i]*1.E2, $
            takeda2[i],result[i,2],(result[i,2]-takeda2[i])/takeda2[i]*1.E2, $
            format='(i4,e10.2,e10.2,i5,e10.2,e10.2,i5,e10.2,e10.2,i5)'
  endfor
  free_lun,unit

; Height Integrated conductivities
  result2d = iug_height_integrated_cond(result)

  s0_takeda = 7.080E6 & s1_takeda = 3.427E1 & s2_takeda = 3.217E1
  sxx_takeda = 1.891E2 & syy_takeda = 3.437E1 & sxy_takeda = 7.555E1

  openw, unit, tmp_dir+'iug_load_ionospheric_cond_diagnostics_1_01_result8.txt', /get_lun
  printf,unit,"s0=",s0_takeda,result2d[0],(result2d[0]-s0_takeda)/s0_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s1=",s1_takeda,result2d[1],(result2d[1]-s1_takeda)/s1_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"s2=",s2_takeda,result2d[2],(result2d[2]-s2_takeda)/s2_takeda*1.E2, $
         format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxx=",sxx_takeda,result2d[3], $
         (result2d[3]-sxx_takeda)/sxx_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'
  printf,unit,"syy=",syy_takeda,result2d[4], $
         (result2d[4]-syy_takeda)/syy_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'
  printf,unit,"sxy=",sxy_takeda,result2d[5], $
         (result2d[5]-sxy_takeda)/sxy_takeda*1.E2, format='(a4,e10.2,e10.2,i5)'

  free_lun,unit

end
