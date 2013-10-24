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
;Yukinobu KOYAMA, 10/23/2013
;
;Acknowledgment:
;
;EXAMPLE:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_map, yyyy=1987, mmdd=101, ltut=0, time=12,
; height_bottom=100, height_top=120, height_step=20, algorithm=1, 
; resolution=30, result=result
;-

pro iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                   height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                   algorithm=algorithm, resolution=resolution, result=result
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
;
;
;
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
  glat_array=fltarr(180/resolution+1)
  glon_array=fltarr(360/resolution+1)

  for i=0L,n_elements(glat_array)-1 do begin
     glat_array[i]=-90.+i*resolution
  endfor

  for i=0L,n_elements(glon_array)-1 do begin
     glon_array[i]=-180.+i*resolution
  endfor

;
;
;
  iug_create_query_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                         height_bottom=height_bottom, heigit_top=height_top, height_step=height_step, $
                                         resolution=resolution, algorithm=algorithm
  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/ionospheric_cond.db < '+tmp_dir+'ionospheric_cond_map_query.sql'

  infile = tmp_dir+'ionospheric_cond_map.result'
  query_result=file_info(infile)

; calc_table in structure
  record = create_struct('height', 0., 'glat', 0., 'glon', 0., 'flag', 0.)
  calc_table = replicate(record, n_elements(glat_array)*n_elements(glon_array)*num_height)

  z = 0

  for i=0L,n_elements(glat_array)-1  do begin
     for j=0L,n_elements(glon_array)-1 do begin
        for k=0L,num_height-1 do begin
           calc_table[z].height = height_array[k]
           calc_table[z].glat = glat_array[i]
           calc_table[z].glon = glon_array[j]
           calc_table[z].flag = 1 ; 
           z=z+1
        endfor
     endfor
  endfor

; calculated_table in structure
  if query_result.size ne 0 then begin
     skip_line=0
     sed_data = read_csv(infile, n_table_header=skip_line, count=cnt)

     calculated_table = replicate(record,cnt)

     if query_result.size ne 0 then begin
        for i=0L,cnt-1 do begin
           calculated_table[i].height = sed_data.field07[i]
           calculated_table[i].glat = sed_data.field08[i]
           calculated_table[i].glon = sed_data.field09[i]
           calculated_table[i].flag = 0 ; do not use
        endfor
     endif

; Compare calc_table & calculated_table
     for i=0L,n_elements(calc_table)-1 do begin
        for j=0L,n_elements(calculated_table)-1 do begin
           if calc_table[i].height eq calculated_table[j].height $
              and calc_table[i].glat eq calculated_table[j].glat $
              and calc_table[i].glon eq calculated_table[j].glon then begin

              calc_table[i].flag = 0 ; skip the calculation, use data in DB

           endif
        endfor
     endfor
  endif

;
  for i=0L,n_elements(calc_table)-1 do begin
     if calc_table[i].flag eq 1 then begin
        iug_load_ionospheric_cond_part1_sub, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                             glat=calc_table[i].glat, glon=calc_table[i].glon, height=calc_table[i].height, $
                                             result=result
     endif
  endfor

; Read DB
  iug_create_query_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                         height_bottom=height_bottom, heigit_top=height_top, height_step=height_step, $
                                         resolution=resolution, algorithm=algorithm
  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/ionospheric_cond.db < '+tmp_dir+'ionospheric_cond_map_query.sql'

  infile = tmp_dir+'ionospheric_cond_map.result'
  query_result=file_info(infile)
  print, "query_result.size=",query_result.size
  
  if query_result.size ne 0 then begin
     skip_line=0
     result_csv = read_csv(infile, n_table_header=skip_line, count=cnt)
  endif

  record = create_struct('sigma_0',0.,'sigma_1',0.,'sigma_2',0., $
                         'sigma_xx',0.,'sigma_yy',0.,'sigma_xy',0., $
                         'height',0.,'glat',0.,'glon',0., $
                         'yyyy',0., 'mmdd',0., 'ltut',0., 'atime',0., 'algorithm',0.)
  result_table = replicate(record, cnt)

  for i=0L, cnt-1 do begin
     result_table[i].sigma_0   = result_csv.field01[i]
     result_table[i].sigma_1   = result_csv.field02[i]
     result_table[i].sigma_2   = result_csv.field03[i]
     result_table[i].sigma_xx  = result_csv.field04[i]
     result_table[i].sigma_yy  = result_csv.field05[i]
     result_table[i].sigma_xy  = result_csv.field06[i]
     result_table[i].height    = result_csv.field07[i]
     result_table[i].glat      = result_csv.field08[i]
     result_table[i].glon      = result_csv.field09[i]
     result_table[i].yyyy      = result_csv.field10[i]
     result_table[i].mmdd      = result_csv.field11[i]
     result_table[i].ltut      = result_csv.field12[i]
     result_table[i].atime     = result_csv.field13[i]
     result_table[i].algorithm = result_csv.field14[i]
  endfor

; ploting
  for m=0L, 5 do begin          ; for sigma_0, sigma_1, sigma_2, sigma_xx, sigma_yy, sigma_xy

     if m eq 0 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_0'
        str_sigma_type = 'sigma_0'
     endif else if m eq 1 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_1'
        str_sigma_type = 'sigma_1'
     endif else if m eq 2 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_2'
        str_sigma_type = 'sigma_2'
     endif else if m eq 3 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_xx'
        str_sigma_type = 'sigma_xx'
     endif else if m eq 4 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_yy'
        str_sigma_type = 'sigma_yy'
     endif else if m eq 5 then begin
        str_title = 'Ionospheric Conductivity Profile, sigma_xy'
        str_sigma_type = 'sigma_xy'
     endif

     if ltut eq 0 then begin
        str_ltut='LT'
     endif else begin
        str_ltut='UT'
     endelse


     str_yyyy = string(yyyy, format='(i4.4)')
     str_mmdd = string(mmdd, format='(i4.4)')
     str_time = string(time, format='(i2.2)')

     for i=0L, n_elements(height_array)-1 do begin

        result_plot = fltarr(n_elements(glon_array), n_elements(glat_array) )

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

;
;        glat=-90 and glat=90 can to work well. To stay away from it.
;
        glat_array(0) = glat_array(0) + 0.1 ; -90 to -89
        glat_array(n_elements(glat_array)-1) = glat_array(n_elements(glat_array)-1) - 0.1 ; +90 to +89
;

        set_plot, 'ps'
        str_height = string(height_array[i], format='(i4.4)')

        device, filename=tmp_dir+'ionospheric_cond_map_'+str_yyyy+'_'+str_mmdd+'_'+str_ltut+str_time+'_'+str_height+'_'+str_sigma_type+'.eps', /color, /encapsulated

        map_set, /isotropic, /cylindrical, 0, 0, title = str_title

        nlevels = 24
        loadct, 33, ncolors=nlevels, bottom=1
        transparency = 50
        contour, result_plot, glon_array, glat_array, /overplot, /cell_fill, nlevels=nlevels, c_colors=IndGen(nlevels)
        map_grid, latdel=10, londel=10, color=240
        map_continents

        device, /close
        set_plot, 'x'

        print, result_plot
     endfor
  endfor

end
