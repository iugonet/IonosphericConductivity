; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_3_00
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 08/22/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
;
;-
pro iug_load_ionospheric_cond_diagnostics_3_00

;
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat = 0
  glon = 0
  yyyy = 2000
  mmdd = 101
  ltut = 0
  time = 0
;
  algorithm = 2 ; Richmond's

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_3_00_result1.ps',/color

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0], result[*,6], xtitle="Conductivity (S/m)", ytitle="Altitude (km)",xrange=[1.E-8,1.E2], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000/01/01, LT0"
  oplot, result[*,1], result[*,6], linestyle=0, color=6
  oplot, result[*,2], result[*,6], linestyle=0, color=2
;
  algorithm = 1 ; Maeda's

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  oplot, result[*,0], result[*,6], linestyle=1, color=0
  oplot, result[*,1], result[*,6], linestyle=1, color=6
  oplot, result[*,2], result[*,6], linestyle=1, color=2

  device,/close
  set_plot,'x'
;
;
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat = 0
  glon = 0
  yyyy = 2000
  mmdd = 101
  ltut = 0
  time = 12
;
  algorithm = 2 ; Richmond's

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_3_00_result2.ps',/color

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0], result[*,6], xtitle="Conductivity (S/m)", ytitle="Altitude (km)",xrange=[1.E-8,1.E2], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000/01/01, LT0"
  oplot, result[*,1], result[*,6], linestyle=0, color=6
  oplot, result[*,2], result[*,6], linestyle=0, color=2
;
  algorithm = 1 ; Maeda's

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  oplot, result[*,0], result[*,6], linestyle=1, color=0
  oplot, result[*,1], result[*,6], linestyle=1, color=6
  oplot, result[*,2], result[*,6], linestyle=1, color=2

  device,/close
  set_plot,'x'
;
;
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat = 0
  glon = 0
  yyyy = 1992
  mmdd = 101
  ltut = 0
  time = 0
; 
  algorithm = 2 ; Richmond's

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_3_00_result3.ps',/color

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0], result[*,6], xtitle="Conductivity (S/m)", ytitle="Altitude (km)",xrange=[1.E-8,1.E2], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000/01/01, LT0"
  oplot, result[*,1], result[*,6], linestyle=0, color=6
  oplot, result[*,2], result[*,6], linestyle=0, color=2
;
  algorithm = 1 ; Maeda's

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  oplot, result[*,0], result[*,6], linestyle=1, color=0
  oplot, result[*,1], result[*,6], linestyle=1, color=6
  oplot, result[*,2], result[*,6], linestyle=1, color=2

  device,/close
  set_plot,'x'
;
;
;
  height_bottom=100
  height_top=400
  height_step=10
  glat = 0
  glon = 0
  yyyy = 1992
  mmdd = 101
  ltut = 0
  time = 12
;
  algorithm = 2 ; Richmond's

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_3_00_result4.ps',/color

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  plot, result[*,0], result[*,6], xtitle="Conductivity (S/m)", ytitle="Altitude (km)",xrange=[1.E-8,1.E2], yrange=[height_bottom,height_top], /xlog, linestyle=0, color=0,title="GLAT=0, GLON=0, 2000/01/01, LT0"
  oplot, result[*,1], result[*,6], linestyle=0, color=6
  oplot, result[*,2], result[*,6], linestyle=0, color=2
;
  algorithm = 1 ; Maeda's

  iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=glat, glon=glon, yyyy=yyyy,mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
  oplot, result[*,0], result[*,6], linestyle=1, color=0
  oplot, result[*,1], result[*,6], linestyle=1, color=6
  oplot, result[*,2], result[*,6], linestyle=1, color=2

  device,/close
  set_plot,'x'
;
;
;
;


end
