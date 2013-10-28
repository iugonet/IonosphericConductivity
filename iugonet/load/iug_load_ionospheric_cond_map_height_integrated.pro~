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

  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, reso_lat=reso_lat, reso_lon=reso_lon, result=result

  
  print, size(result)
  print, "HOGE", result.sigma_0
  print, "HOGE", result.sigma_1
  print, "HOGE", result.sigma_2
  print, "HOGE", result.sigma_xx
  print, "HOGE", result.sigma_yy
  print, "HOGE", result.sigma_xy
  print, "HOGE", result.height
  print, "HOGE", result.glat
  print, "HOGE", result.glon
  
end
