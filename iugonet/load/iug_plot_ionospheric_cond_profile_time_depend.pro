; docformat = 'IDL'

;+
;
;Name: IUG_PLOT_IONOSPHERIC_COND_PROFILE_TIME_DEPEND
;
;Code: Yukinobu KOYAMA
;
;Modifications:
;
;EXAMPLE:
;   iug_plot_ionospheric_cond_profile_time_depend
;-
pro iug_plot_ionospheric_cond_profile_time_depend, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, algorithm=algorithm, result=result

; validate height_bottom
  if height_bottom lt 80 then begin
     dprint,"Satisfy this constraint 'height >= 80'."
     return
  endif
; validate height_top
  if height_top gt 2000 then begin
     dprint,"Specify height_top < 2000(km)."
     return
  endif
; validate height_step                                                         
  if height_step gt height_top-height_bottom then begin
     dprint,"Satisfy this constraint 'height_step < height_top-height_bottom'."
     return
  endif
; validate glat 
  if glat lt -90 and glat gt 90 then begin
     dprint,"Specify glat in -90 to 90."
     return
  endif
; validate glon                                                               
  if glon lt -180 and glon gt 180 then begin
     dprint,"Specify glon in -180 to 180."
     return
  endif
; validate yyyy
  if yyyy lt 1958 and yyyy ge 2013 then begin
     dprint,"Specify yyyy in 1958 to 2012."
     return
  endif
; validate mmdd
  if mmdd lt 101 and mmdd gt 1231 then begin
     dprint,"Specify mmdd correctly."
     return
  endif
; validate algorithm
  if algorithm ne 1 and algorithm ne 2 then begin
     dprint,"Specify algorithm correctly."
     dprint,"Collision frequency is calculated by ..."
     dprint,"   1: Banks, P. M., G. Kocharts, Aeronomy pt. A. - Academic Press, 1973"
     dprint,"   2: Haris Volland, Handbook of ATMOSPHERIC ELECTORODYNAMICS, Volume II, CRC Press, 1995."
     return
  endif
;
  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse 
;
  result_time_depend = fltarr(7,num_height,24)
;
  if algorithm eq 1 then begin
     for time=0L,23 do begin
        iug_load_ionospheric_cond_part1, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=0, time=time, result=result
        result_time_depend[*,*,time] = result
     endfor
  endif
  if algorithm eq 2 then begin
     for time=0L,23 do begin
        iug_load_ionospheric_cond_part2, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=0, time=time, result=result
        result_time_depend[*,*,time] = result
     endfor
  endif
;
  height_array=fltarr(num_height)

  for i=0L,n_elements(height_array)-1 do begin
     height_array(i) = height_bottom+height_step*i
  endfor
;
  time_array=intarr(24)

  for i=0L,n_elements(time_array)-1 do begin
     time_array(i) = i
  endfor

  print, result_time_depend
;
  surface, dist(100), /nodata, /save,$
           xrange=[100,400], yrange=[0,23], zrange=[1.E-3,1.E1], $
           title="Ionospheric Conductivity (S/m)", charsize = 2., $
           xtitle="Height (km)", ytitle="Local Time (hour)", $
           ztitle="Conductivity (S/m)", $
           ax=30, az=10, /zlog

  print,time_array

  for i=0L, n_elements(time_array)-1 do begin
     if i mod 6 eq 0 then begin
        plots, height_array[*], time_array[i]-1, result_time_depend[0,*,0],$
               /t3d, psym=0, symsize=1.0, thick=2.0
     endif else begin
        plots, height_array[*], time_array[i]-1, result_time_depend[0,*,0],$
               /t3d, psym=0, symsize=1.0, thick=1.0
     endelse
     
  endfor

end
