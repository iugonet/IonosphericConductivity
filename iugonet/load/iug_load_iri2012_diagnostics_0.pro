; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IRI2012_DIAGNOSTICS_0
;
;-

pro iug_load_iri2012_diagnostics_0
  
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

  yyyy = 2000
  mmdd = 101
  ltut = 0
  time = 0
  glat = 0
  glon = 0
  height_bottom = 100
  height_top = 400
  height_step = 10

  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

; 2000-01-01, LT0, (0,0) by
; http://ccmc.gsfc.nasa.gov/modelweb/models/iri_vitmo.php 
; which is based on "IRI-2007".
  a=[100.00,  110.00,  120.00,  130.00,  140.00,  150.00,  160.00,  170.00,  180.00,  190.00,  200.00,  210.00,  220.00,  230.00,  240.00,  250.00,  260.00,  270.00,  280.00,  290.00,  300.00,  310.00,  320.00,  330.00,  340.00,  350.00,  360.00,  370.00,  380.00,  390.00,  400.00]
  b=[0.30860E+10,  0.32959E+10,  0.18668E+10,  0.83844E+09,  0.68052E+09,  0.11765E+10,  0.28205E+10,  0.45566E+10,  0.69844E+10,  0.10817E+11,  0.16985E+11,  0.27196E+11,  0.44838E+11,  0.72865E+11,  0.11270E+12,  0.16618E+12,  0.23403E+12,  0.31529E+12,  0.40709E+12,  0.50467E+12,  0.60190E+12,  0.69210E+12,  0.76909E+12,  0.82821E+12,  0.86711E+12,  0.88624E+12,  0.88931E+12,  0.88065E+12,  0.86205E+12,  0.83547E+12,  0.80286E+12]

  set_plot,'ps'
  device,filename='iug_load_iri2012_diagnostics_0_result1.ps',/color
  plot,result_iri[*,1]*1.e6,a[*],xtitle="Electron Density [m-3]",ytitle="Height [km]",/xlog,linestyle=0,color=0,title="GLAT=0, GLON=0, 2000/01/01, LT0",xrange=[1E8,1E13],yrange=[100,400]
  oplot,b[*],a[*],linestyle=1,color=0

  xyouts,2e8,360,"  solid line - Actual  by Koyama (by using IRI2012)"
  xyouts,2e8,340,"dotted line - Expected by VITMO (by using IRI2007)"
  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_iri2012_diagnostics_0_result1.txt', /get_lun
  for i=0L,n_elements(a)-1 do begin
     printf,unit,a[i],result_iri[i,1]*1.e6,b[i],(result_iri[i,1]*1.e6-b[i])/b[i]*100.,format='(i4,e10.2,e10.2,f8.4)'
  endfor
  free_lun,unit
;
;
;
  yyyy = 2000
  mmdd = 101
  ltut = 0
  time = 12
  glat = 0
  glon = 0
  height_bottom = 100
  height_top = 400
  height_step = 10

  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

; 2000-01-01, LT12, (0,0) 
  a=[  100.00,  110.00,  120.00,  130.00,  140.00,  150.00,  160.00,  170.00,  180.00,  190.00,  200.00,  210.00,  220.00,  230.00,  240.00,  250.00,  260.00,  270.00,  280.00,  290.00,  300.00,  310.00,  320.00,  330.00,  340.00,  350.00,  360.00,  370.00,  380.00,  390.00,  400.00]
  b=[  0.16333E+12,  0.18853E+12,  0.18990E+12,  0.19405E+12,  0.19841E+12,  0.20302E+12,  0.20790E+12,  0.21312E+12,  0.21872E+12,  0.22478E+12,  0.23142E+12,  0.23881E+12,  0.24723E+12,  0.25722E+12,  0.27005E+12,  0.29212E+12,  0.32475E+12,  0.35433E+12,  0.37512E+12,  0.44048E+12,  0.51325E+12,  0.59277E+12,  0.67841E+12,  0.76919E+12,  0.86379E+12,  0.96051E+12,  0.10573E+13,  0.11518E+13,  0.12415E+13,  0.13236E+13,  0.13954E+13]

  set_plot,'ps'
  device,filename='iug_load_iri2012_diagnostics_0_result2.ps',/color
  plot,result_iri[*,1]*1.e6,a[*],xtitle="Electron Density [m-3]",ytitle="Height [km]",/xlog,linestyle=0,color=0,title="GLAT=0, GLON=0, 2000/01/01, LT12",xrange=[1E8,1E13],yrange=[100,400]
  oplot,b[*],a[*],linestyle=1,color=0

  xyouts,2e8,360,"  solid line - Actual  by Koyama (by using IRI2012)"
  xyouts,2e8,340,"dotted line - Expected by VITMO (by using IRI2007)"
  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_iri2012_diagnostics_0_result2.txt', /get_lun
  for i=0L,n_elements(a)-1 do begin
     printf,unit,a[i],result_iri[i,1]*1.e6,b[i],(result_iri[i,1]*1.e6-b[i])/b[i]*100.,format='(i4,e10.2,e10.2,f8.4)'
  endfor
  free_lun,unit
;
;
;
  yyyy = 1992
  mmdd = 101
  ltut = 0
  time = 0
  glat = 0
  glon = 0
  height_bottom = 100
  height_top = 400
  height_step = 10

  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

; 1992-01-01, LT0, (0,0)
  a=[  100.00,  110.00,  120.00,  130.00,  140.00,  150.00,  160.00,  170.00,  180.00,  190.00,  200.00,  210.00,  220.00,  230.00,  240.00,  250.00,  260.00,  270.00,  280.00,  290.00,  300.00,  310.00,  320.00,  330.00,  340.00,  350.00,  360.00,  370.00,  380.00,  390.00,  400.00]
  b=[  0.33202E+10,  0.35624E+10,  0.20270E+10,  0.90869E+09,  0.73598E+09,  0.12882E+10,  0.31220E+10,  0.49956E+10,  0.76543E+10,  0.11833E+11,  0.18514E+11,  0.29448E+11,  0.48003E+11,  0.77660E+11,  0.11986E+12,  0.17675E+12,  0.24944E+12,  0.33741E+12,  0.43818E+12,  0.54723E+12,  0.65841E+12,  0.76462E+12,  0.85890E+12,  0.93541E+12,  0.99047E+12,  0.10231E+13,  0.10354E+13,  0.10324E+13,  0.10170E+13,  0.99102E+12,  0.95685E+12]

  set_plot,'ps'
  device,filename='iug_load_iri2012_diagnostics_0_result3.ps',/color
  plot,result_iri[*,1]*1.e6,a[*],xtitle="Electron Density [m-3]",ytitle="Height [km]",/xlog,linestyle=0,color=0,title="GLAT=0, GLON=0, 1992/01/01, LT0",xrange=[1E8,1E13],yrange=[100,400]
  oplot,b[*],a[*],linestyle=1,color=0

  xyouts,2e8,360,"  solid line - Actual  by Koyama (by using IRI2012)"
  xyouts,2e8,340,"dotted line - Expected by VITMO (by using IRI2007)"
  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_iri2012_diagnostics_0_result3.txt', /get_lun
  for i=0L,n_elements(a)-1 do begin
     printf,unit,a[i],result_iri[i,1]*1.e6,b[i],(result_iri[i,1]*1.e6-b[i])/b[i]*100.,format='(i4,e10.2,e10.2,f8.4)'
  endfor
  free_lun,unit
;
;
;
  yyyy = 1992
  mmdd = 101
  ltut = 0
  time = 12
  glat = 0
  glon = 0
  height_bottom = 100
  height_top = 400
  height_step = 10

  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

; 1992-01-01, LT12, (0,0)
  a=[  100.00,  110.00,  120.00,  130.00,  140.00,  150.00,  160.00,  170.00,  180.00,  190.00,  200.00,  210.00,  220.00,  230.00,  240.00,  250.00,  260.00,  270.00,  280.00,  290.00,  300.00,  310.00,  320.00,  330.00,  340.00,  350.00,  360.00,  370.00,  380.00,  390.00,  400.00]
  b=[  0.17049E+12,  0.19526E+12,  0.19678E+12,  0.20099E+12,  0.20541E+12,  0.21007E+12,  0.21501E+12,  0.22026E+12,  0.22588E+12,  0.23194E+12,  0.23853E+12,  0.24580E+12,  0.25397E+12,  0.26343E+12,  0.27496E+12,  0.29091E+12,  0.32136E+12,  0.35456E+12,  0.38345E+12,  0.41791E+12,  0.48875E+12,  0.56697E+12,  0.65228E+12,  0.74406E+12,  0.84138E+12,  0.94294E+12,  0.10471E+13,  0.11518E+13,  0.12549E+13,  0.13536E+13,  0.14453E+13]

  set_plot,'ps'
  device,filename='iug_load_iri2012_diagnostics_0_result4.ps',/color
  plot,result_iri[*,1]*1.e6,a[*],xtitle="Electron Density [m-3]",ytitle="Height [km]",/xlog,linestyle=0,color=0,title="GLAT=0, GLON=0, 1992/01/01, LT12",xrange=[1E8,1E13],yrange=[100,400]
  oplot,b[*],a[*],linestyle=1,color=0

  xyouts,2e8,360,"  solid line - Actual  by Koyama (by using IRI2012)"
  xyouts,2e8,340,"dotted line - Expected by VITMO (by using IRI2007)"
  device,/close
  set_plot,'x'

  openw, unit, tmp_dir+'iug_load_iri2012_diagnostics_0_result4.txt', /get_lun
  for i=0L,n_elements(a)-1 do begin
     printf,unit,a[i],result_iri[i,1]*1.e6,b[i],(result_iri[i,1]*1.e6-b[i])/b[i]*100.,format='(i4,e10.2,e10.2,f8.4)'
  endfor
  free_lun,unit
end
