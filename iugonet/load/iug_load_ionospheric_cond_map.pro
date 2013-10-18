; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_MAP
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 05/05/2012
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_map, yyyy=1987, mmdd=101, ltut=0, time=12,
; height_bottom=100, height_top=120, height_step=20, algorithm=1, 
; resolution=30, result=result
;-

pro iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, height_bottom=height_bottom, height_top=height_top, height_step=height_step, algorithm=algorithm, resolution=resolution, result=result
  
; validate height_bottom 
  if height_bottom lt 80 then begin
     dprint,"Satisfy this constraint 'height_bottom >= 80'."
;     dprint,"This procedure don't consider the cluster ion's
;     influence under the altitude of 100km."
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
     dprint,"Specify algorithm correctry."
     dprint,'1: Ken-ichi Maedas, 2: by Richmonds book'
     return
  endif

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  height_array=fltarr(num_height)

  for i=0L,num_height-1 do begin
     height_array(i)=height_bottom+height_step*i
  endfor
;
; Calculation based on Kenichi Maeda's equation
;
  glat_list=fltarr(180/resolution+1)
  glon_list=fltarr(360/resolution+1)

  for i=0L,n_elements(glat_list)-1 do begin
     glat_list[i]=-90.+i*resolution
  endfor

  for i=0L,n_elements(glon_list)-1 do begin
     glon_list[i]=-180.+i*resolution
  endfor


;  result = fltarr(num_height,7)
  result2 = fltarr(n_elements(glat_list),n_elements(glon_list),num_height,7)

;
;
;
  iug_create_query_ionospheric_cond_map,height_bottom=height_bottom, heigit_top=height_top, height_step=height_step, resolution=resolution, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm
  spawn,'sqlite3 -separator " " ${UDASPLUS_HOME}/iugonet/load/ionospheric_cond.db < /tmp/ionospheric_cond_map_query.sql > /tmp/ionospheric_cond_map.result'
  query_result=file_info('/tmp/ionospheric_cond_map.result')

;  exit
;
;
;
  for i=0L,n_elements(glat_list)-1  do begin
     for j=0L,n_elements(glon_list)-1 do begin
        for k=0L,num_height-1 do begin
           iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat_list[i], glon=glon_list[j], yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result
           for l=0L,7-1 do begin
              result2[i,j,k,l]=result[k,l]
           endfor
           exit
        endfor
     endfor
  endfor

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_map.ps',/color,/encapsulated

  map_set, /CYLINDRICAL, 0, 0, /GRID, /CONTINENTS, $  
           TITLE = 'Ionospheric Conductivity'

; BE CAREFULL
  result3 = fltarr(n_elements(glon_list),n_elements(glat_list))

  for i=0L,n_elements(glat_list)-1 do begin
     for j=0L,n_elements(glon_list)-1 do begin
        result3[j,i]=result2[i,j,0,0]
     endfor
  endfor

  nlevels=12
  LoadCT, 33, NColors=nlevels, Bottom=1
  transparency=50
  contour, result3, glon_list, glat_list, /overplot,/fill,nlevels=nlevels,c_colors=IndGen(nlevels)+1
  map_grid, latdel=10, londel=10, color=240
  map_continents
  set_plot,'x'

end
