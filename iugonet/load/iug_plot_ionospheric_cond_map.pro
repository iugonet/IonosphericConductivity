; docformat = 'IDL'

;+
;Name:
;IUG_PLOT_IONOSPHERIC_COND_MAP
;
;-
pro iug_plot_ionospheric_cond_map, height=height, resolution=resolution, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm

; validate height_bottom
  if height lt 80 then begin
     dprint,"Satisfy this constraint 'height >= 80'."
     return
  endif
; validate glon
  if resolution gt 45  then begin
     dprint,"Specify glon in 0.1 to 45."
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
; validate ltut
  if ltut ne 0 and ltut ne 1 then begin
     dprint,"Specify ltut correctly."
     dprint,"   0:lt, 1:ut"
     return
  endif

; validate time
  if time lt 0 and time gt 24 then begin
     dprint,"Specify time in 0 to 24."
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
  glat_array = fltarr(360/resolution+1, 180/resolution+1)
  size_glat_array = size(glat_array)
  num_x = size_glat_array(1)
  num_y = size_glat_array(2)
;
  for i=0L,num_x-1 do begin
     for j=0L,num_y-1 do begin
        glat_array[i,j] = -90. + j*resolution
     endfor
  endfor
;
  glon_array = fltarr(360/resolution+1, 180/resolution+1)
  size_glon_array = size(glon_array)
  num_x = size_glon_array(1)
  num_y = size_glon_array(2)
;
  for i=0L,num_x-1 do begin
     for j=0L,num_y-1 do begin
        glon_array[i,j] = -180. + i*resolution
     endfor
  endfor 
;
  result_map = fltarr(360/resolution+1, 180/resolution+1)

;
  if algorithm eq 1 then begin
     for i=0L,num_x-1 do begin ; glon
        for j=0L,num_y-1 do begin ; glat
           iug_load_ionospheric_cond_part1, height_bottom=height, height_top=height, height_step=0, glat=glat_array[i,j], glon=glon_array[i,j], yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result
           result_map[i,j]=result[1]
;           print,"HOGE",result[1],glat_array[j],glon_array[i]
;           if glat_array[i,j] eq 0 and glon_array[i,j] eq 0 then begin
;              print,"glat_array=",glat_array[i,j]
;              print,"glon_array=",glon_array[i,j]
;              print,"hoge"
;              stop
;           endif
        endfor
     endfor
  endif
  if algorithm eq 2 then begin
     for i=0L,num_x-1 do begin ; glon
        for j=0L,num_y-1 do begin ; glat
           iug_load_ionospheric_cond_part2, height_bottom=height_bottom, height_top=height_top, height_step=0, glat=glat_array[i,j], glon=glon_array[i,j], yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result
           result_map[i,j]=result[1]
        endfor
     endfor
  endif
; Make a RESOLUTION degree latitude/longitude grid covering the Earth:

  tek_color
  map_SET, /CYLINDRICAL, 0, 0, 0, $  
           /GRID, /CONTINENT, /HORIZON, $  
           TITLE='Ionospheric Conductivity' 
  contour,result_map[*,*],glon_array[*,*],glat_array[*,*], /fill, /overplot, $
          NLEVELS=10
  map_grid, /label, color=fff
  map_continents, color=fff
  colorbar

end
