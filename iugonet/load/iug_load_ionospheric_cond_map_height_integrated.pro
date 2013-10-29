; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_MAP_HEIGHT_INTEGRATED
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/23/2013
;
;Modifications:
;
;
;Acknowledgment:
;
;EXAMPLE:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_map_height_integrated, yyyy=1987, mmdd=101, ltut=0, time=12,
; height_bottom=100, height_top=120, height_step=20, algorithm=1, 
; reso_lat=30, reso_lon=30, result=result
;-

pro iug_load_ionospheric_cond_map_height_integrated, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                   height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                   algorithm=algorithm, reso_lat=reso_lat, reso_lon=reso_lon, result=result

;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin
     file_mkdir, tmp_dir
  endif
;

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

  height_array = fltarr(num_height)

  for i=0L, num_height-1 do begin
     height_array(i) = height_bottom+height_step * 1
  endfor
;
; Calculation based on Kenichi Maeda's equation
;
  glat_array = fltarr(180/reso_lat+1)
  glon_array = fltarr(360/reso_lon+1)

  for i=0L,n_elements(glat_array)-1 do begin
     glat_array[i]=-90.+i*reso_lat
  endfor

  for i=0L,n_elements(glon_array)-1 do begin
     glon_array[i]=-180.+i*reso_lon
  endfor

;
;
;
  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, reso_lat=reso_lat, reso_lon=reso_lon, result=result

  str_height_range = string(height_bottom, format='(i4.4)')+'-'+string(height_top, format='(i4.4)')
  str_height = str_height_range

  result_table = result

;
; Just before ploting. glat=-90 and glat=90 can to work well. To stay away from it.
;
  glat_array4plot = glat_array
  glat_array4plot(0) = glat_array4plot(0) + 0.1                           ; -90 to -89
  glat_array4plot(n_elements(glat_array4plot)-1) = glat_array4plot(n_elements(glat_array4plot)-1) - 0.1 ; +90 to +89

; plotting
  for m=0L, 5 do begin          ; for sigma_0, sigma_1, sigma_2, sigma_xx, sigma_yy, sigma_xy

     if ltut eq 0 then begin
        str_ltut='LT'
     endif else begin
        str_ltut='UT'
     endelse

     str_yyyy = string(yyyy, format='(i4.4)')
     str_mmdd = string(mmdd, format='(i4.4)')
     str_time = string(time, format='(i2.2)')

     if m eq 0 then begin
        str_title = 'Height Integrated Ionospheric Conductivity, sigma_0, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_0'
     endif else if m eq 1 then begin
        str_title = 'Heignt Integrated Ionospheric Conductivity, sigma_1, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_1'
     endif else if m eq 2 then begin
        str_title = 'Height Integrated Ionospheric Conductivity, sigma_2, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_2'
     endif else if m eq 3 then begin
        str_title = 'Height Integrated Ionospheric Conductivity, sigma_xx, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_xx'
     endif else if m eq 4 then begin
        str_title = 'Height Integrated Ionospheric Conductivity, sigma_yy, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_yy'
     endif else if m eq 5 then begin
        str_title = 'Heignt Integrated Ionospheric Conductivity, sigma_xy, !C'+str_yyyy+'-'+str_mmdd+'-'+str_time+str_ltut+' ('+str_height+' km)'
        str_sigma_type = 'sigma_xy'
     endif

     result_plot_height_integrated = fltarr(n_elements(glon_array), n_elements(glat_array))

     for i=0L, n_elements(height_array)-1 do begin

        result_plot = fltarr(n_elements(glon_array), n_elements(glat_array))

        cnt = n_elements(result_table)

        for j=0L, cnt-1 do begin
           for k=0L, n_elements(glat_array)-1 do begin
              for l=0L, n_elements(glon_array)-1 do begin
                 if result_table[j].height eq height_array(i) $
                    and result_table[j].glat eq glat_array[k] $
                    and result_table[j].glon eq glon_array[l] then begin

                    if m eq 0 then begin
                       result_plot(l,k) = result_table[j].sigma_0
                    endif else if m eq 1 then begin
                       result_plot(l,k) = result_table[j].sigma_1
                    endif else if m eq 2 then begin
                       result_plot(l,k) = result_table[j].sigma_2
                    endif else if m eq 3 then begin
                       result_plot(l,k) = result_table[j].sigma_xx
                    endif else if m eq 4 then begin
                       result_plot(l,k) = result_table[j].sigma_yy
                    endif else if m eq 5 then begin
                       result_plot(l,k) = result_table[j].sigma_xy
                    endif 
                 endif
              endfor
           endfor
        endfor

        if i gt 0 then begin
           result_plot_height_integrated = result_plot_height_integrated $
                                           + (result_plot + result_plot_lower) /2. * height_step * 1.E3
        endif

        result_plot_lower = result_plot
     endfor

;
     set_plot, 'ps'

     device, filename=tmp_dir+'ionospheric_cond_map_'+str_yyyy+'_'+str_mmdd+'_'+str_time+str_ltut+'_'+str_height+'_'+str_sigma_type+'.eps', /color, /encapsulated

;
     map_set, /isotropic, /cylindrical, 0, 0, title = str_title, position=[0.07,0.05,0.87,0.85]

     nlevels = 24
     loadct, 33, ncolors=nlevels, bottom=1
     transparency = 50

     contour, alog10(result_plot_height_integrated), glon_array, glat_array4plot, $
              /overplot, /cell_fill, nlevels=nlevels, c_colors=IndGen(nlevels), position=[0.0,0.0,0.93,0.93]
;, zaxis=1, xstyle=1
; color bar
     colorbar, ncolors=nlevels, position=[0.18, 0.88, 0.73, 0.90], range=[1e-10,1e1], bottom=1, divisions=4, vertical="vertical", right="right", format='(e8.1)'
     map_grid, latdel=10, londel=10, color=240
     map_continents

     device, /close
     set_plot, 'x'
; txt
     openw, unit, tmp_dir+'ionospheric_cond_map_'+str_yyyy+'_'+str_mmdd+'_'+str_time+str_ltut+'_'+str_height+'_'+str_sigma_type+'.txt', /get_lun
     printf, unit, result_plot_height_integrated
     printf, unit, "GLON_ARRAY=",glon_array
     printf, unit, "GLAT_ARRAY=",glat_array
     free_lun, unit

     print, max(result_plot)

  endfor
end
