; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IGRF11_ARRAY
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/21/2013
;
;Modifications:
;
;Acknowledgment:
;
;Example:
;  iug_load_igrf11_array, height_bottom=100, height_top=120,
;height_step=10, yyyy=2000, glat=0, glon=0, r_d=r_d,r_i=r_i,r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f
;  print, r_h, r_d, r_z, r_f
;  print, r_x, r_y,rt_z, r_f
;
;-

pro iug_load_igrf11_array, height_bottom=height_bottom, height_top=height_top, height_step=height_step, yyyy=yyyy, glat=glat, glon=glon, r_d=r_d, r_i=r_i, r_h=r_h, r_x=r_x, r_y=r_y, r_z=r_z, r_f=r_f
  
; validate height_bottom
  if height_bottom lt 80 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height_bottom
  if height_bottom gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
; validate height_top
  if height_top lt 80 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height_top
  if height_top gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif
;
;
;
  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse
;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin 
     file_mkdir, tmp_dir
  endif
;
  r_d = fltarr(num_height)
  r_i = fltarr(num_height)
  r_h = fltarr(num_height)
  r_x = fltarr(num_height)
  r_y = fltarr(num_height)
  r_z = fltarr(num_height)
  r_f = fltarr(num_height)

  for i=0L,num_height-1 do begin
;;;
     height=height_bottom+height_step*i

     iug_load_igrf11, height=height, yyyy=yyyy, glat=glat, glon=glon, r_d=temp0, r_i=temp1, r_h=temp2, r_x=temp3, r_y=temp4, r_z=temp5, r_f=temp6

     r_d[i] = temp0
     r_i[i] = temp1
     r_h[i] = temp2
     r_x[i] = temp3
     r_y[i] = temp4
     r_z[i] = temp5
     r_f[i] = temp6
  endfor

end
