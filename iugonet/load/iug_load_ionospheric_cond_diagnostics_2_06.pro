; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_2_06
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
; THEMIS> iug_load_ionospheric_cond_diagnostics_2_06
;-

pro iug_load_ionospheric_cond_diagnostics_2_06

  height_bottom=100
  height_top=400
  height_step=10
  mmdd=321

  num_height = (height_top-height_bottom)/height_step+1
  height_array=fltarr(num_height)

  for i=0L,num_height-1 do begin
     height_array(i)=height_bottom+height_step*i
  endfor

;
; Calculation based on Kenichi Maeda's equation
;
  result = fltarr(6,num_height)

  glat=44.6
  glon=2.2
  ltut=0
  time=12
  yyyy=1987

  for i=0L,num_height-1 do begin
     iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result,algorithm=1
  endfor

  set_plot,'ps'
  device,filename='iug_load_ionospheric_cond_diagnostics_2_06.ps',/color

  plot,result[1,*],result[6,*],xtitle="Pedersen Conductivities (S/m)", $
       ytitle="Altitude (km)",yrange=[0,400],xrange=[1E-8,1E-3],/xlog, $
       linestyle=0, color=0, title="GLAT=44.6, GLON=2.2, on March 21"
  xyouts,5E-6,350,"Solar maximum",color=6
  xyouts,3E-5,170,"Noon",color=2
  xyouts,1E-7,350,"Solar minimum",color=6
  xyouts,2E-7,170,"Midnight",color=2

;
; Calculation2
;
  result=0

  glat=44.6
  glon=2.2
  ltut=0
  time=12
  yyyy=1991

  for i=0L,num_height-1 do begin
     iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result, algorithm=1
  endfor

  oplot,result[1,*],result[6,*],linestyle=0, color=3

;
; Calculation3
;
  result=0

  glat=44.6
  glon=2.2
  ltut=0
  time=12
  yyyy=1987

  for i=0L,num_height-1 do begin
     iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result, algorithm=1
  endfor

  oplot,result[1,*],result[6,*],linestyle=0, color=4

;
; Calculation4
;
  result=0

  glat=44.6
  glon=2.2
  ltut=0
  time=0
  yyyy=1987

  for i=0L,num_height-1 do begin
     iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result, algorithm=1
  endfor

  oplot,result[1,*],result[6,*],linestyle=0, color=5

; Solar maximum, noon
  a=[1.03E-08,1.34E-08,2.70E-08,4.53E-08,7.73E-08,1.24E-07,2.66E-07,5.82E-07,1.08E-06,1.47E-06,1.10E-06,9.37E-07,1.36E-06,1.97E-06,2.97E-06,5.51E-06,8.67E-06,1.42E-05,1.94E-05,2.69E-05,3.75E-05,5.54E-05,9.28E-05,0.000137242,0.000172175,0.00025469,0.000313103,0.000313103,0.000276882,0.000225439,0.000183555,0.000146405,0.000119217,9.91E-05,8.59E-05,7.76E-05,7.15E-05,6.46E-05,7.02E-05,7.63E-05,8.46E-05,8.65E-05,9.03E-05,8.67E-05,8.16E-05,7.68E-05,7.08E-05,6.53E-05,5.89E-05,5.21E-05,4.71E-05,4.16E-05,3.68E-05,3.26E-05,2.94E-05,2.60E-05,2.30E-05,1.99E-05,1.76E-05,1.56E-05]
  b=[58.3167,59.3874,62.5809,63.6955,64.8137,66.9439,66.0563,67.2184,69.3743,75.5675,80.6314,84.6943,84.7601,87.8951,87.9683,91.1473,95.3199,98.4769,99.5548,103.706,105.81,107.926,111.086,114.225,116.311,118.427,123.579,123.579,129.695,133.751,137.806,141.858,146.937,154.065,160.178,172.436,184.697,193.886,200.039,209.261,217.464,230.767,244.074,259.412,269.631,278.828,289.044,297.213,306.402,314.565,323.754,331.916,340.078,348.241,356.407,364.569,372.731,380.89,389.052,397.215]

; Solar minimum, noon
  c=[1.01E-08,1.14E-08,1.58E-08,2.20E-08,2.65E-08,3.39E-08,4.72E-08,6.56E-08,9.31E-08,1.17E-07,1.49E-07,1.84E-07,2.35E-07,3.01E-07,3.78E-07,5.37E-07,4.28E-07,3.34E-07,4.46E-07,6.33E-07,1.06E-06,1.97E-06,3.65E-06,6.24E-06,1.16E-05,1.90E-05,2.99E-05,4.42E-05,7.10E-05,0.000109431,0.000146036,0.000211709,0.000149295,9.69E-05,6.69E-05,4.62E-05,3.20E-05,2.45E-05,2.08E-05,1.56E-05,1.17E-05,7.96E-06,5.50E-06,3.43E-06,2.19E-06,1.34E-06,8.33E-07,5.20E-07,3.05E-07,1.94E-07]
  d=[55.244,56.289,56.3475,56.4061,58.4851,60.5751,60.6337,62.7383,62.8005,64.8869,64.9308,65.9904,66.0344,68.1244,69.1877,74.3651,78.4169,84.5112,85.5855,86.6708,88.8084,91.9873,94.1432,96.2844,100.486,103.643,106.793,108.909,111.039,115.208,117.305,123.509,131.631,137.693,143.765,150.86,164.094,183.484,204.939,224.325,238.596,258.987,275.29,296.69,314.001,333.351,348.612,366.943,384.239,400.527]

; Solar maximum, midnight
  e=[1.03E-08,1.65E-08,3.13E-08,5.03E-08,7.14E-08,1.08E-07,1.47E-07,2.13E-07,3.56E-07,6.21E-07,9.98E-07,1.64E-06,2.23E-06,2.98E-06,2.19E-06,1.67E-06,1.31E-06,9.41E-07,7.35E-07,5.63E-07,5.87E-07,6.79E-07,6.95E-07,7.88E-07,9.30E-07,1.14E-06,1.63E-06,2.22E-06,3.02E-06,3.80E-06,4.58E-06,5.19E-06,5.30E-06,4.89E-06,4.42E-06,3.68E-06,3.19E-06,2.71E-06,2.16E-06]
  f=[81.8466,82.9538,83.0673,83.1515,85.2598,89.4251,92.5491,94.6611,96.7987,99.9666,103.12,106.277,109.401,116.613,123.72,125.718,127.72,129.708,133.756,142.916,154.177,165.456,188.989,206.403,219.731,234.091,243.36,254.668,264.954,276.247,288.557,305.97,319.273,334.604,350.955,365.244,375.449,386.673,400.955]

; Solar minimum, midnight
  g=[9.88E-09,1.49E-08,2.39E-08,3.77E-08,5.35E-08,7.75E-08,1.15E-07,1.50E-07,2.17E-07,3.22E-07,5.17E-07,6.75E-07,9.59E-07,1.28E-06,9.21E-07,7.05E-07,5.51E-07,4.58E-07,3.23E-07,2.74E-07,2.18E-07,2.19E-07,2.10E-07,1.78E-07,1.45E-07,1.31E-07,1.55E-07,2.03E-07,2.71E-07,3.55E-07,4.19E-07,5.15E-07,5.72E-07,4.96E-07,3.80E-07,3.16E-07,2.47E-07,1.82E-07,1.39E-07,1.13E-07,9.23E-08,7.36E-08,5.76E-08]
h=[80.8162,81.9125,80.9736,82.0772,83.1624,84.2514,92.5052,94.5989,99.7799,101.896,105.049,107.142,110.274,115.44,121.52,123.518,127.567,129.58,132.587,135.626,140.701,157.07,170.362,182.609,197.918,213.245,227.597,235.829,243.042,252.297,262.556,274.869,288.187,304.53,319.828,331.048,342.258,352.433,362.616,372.81,380.958,387.056,399.288]

  oplot,a,b,linestyle=1,color=0
  oplot,c,d,linestyle=1,color=0
  oplot,e,f,linestyle=1,color=0
  oplot,g,h,linestyle=1,color=0

  device,/close
  set_plot,'x'

end
