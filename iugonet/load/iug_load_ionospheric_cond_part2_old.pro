; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_PART2
;
;Purpose:
;
;
;Syntax:
;
;Keywords:
;
;
;Code:
;Yukinobu KOYAMA, 9/17/2011.
;
;Modifications:
;Yukinobu KOYAMA, 01/10/2011.
;Yukinobu KOYAMA, 01/04/2012.
;
;Acknowledgment:
;
;EXAMPLE:
; IDL> thm_init
; THEMIS> set_plot,'ps'
; THEMIS> device,filename='iug_ionospheric_cond.ps'
; THEMIS>
; THEMIS> station = iug_abb2coordinate('kak')
; THEMIS> print,station
; THEMIS> HEIGHT_BOTTOM=100
; THEMIS> HEIGHT_TOP=400
; THEMIS> HEIGHT_STEP=10
; THEMIS> iug_load_ionospheric_cond, height_bottom=height_bottom, $
;         height_top=height_top,;height_step=height_step,glat=station.glat,
;glon=station.glon,yyyy=2000,mmdd=130,ltut=0,time=12,result=result
; THEMIS>
; THEMIS> plot, result[1,*], result[0,*], xtitle="Conductivity !9s!30 (S/m)", 
;         ytitle="Height (km)", xrange=[0,1], yrange=[HEIGHT_BOTTOM,HEIGHT_TOP], /xlog
; THEMIS> plot, result[2,*], result[0,*], xtitle="Conductivity !9s!31 (S/m)",
;         ytitle="Height (km)", xrange=[0,1], yrange=[HEIGHT_BOTTOM,HEIGHT_TOP], /xlog
; THEMIS> plot, result[3,*], result[0,*], xtitle="Conductivity !9s!32 (S/m)",
;         ytitle="Height (km)", xrange=[0,1], yrange=[HEIGHT_BOTTOM,HEIGHT_TOP], /xlog
; THEMIS>
; THEMIS> set_plot,'x'
; THEMIS>
; THEMIS> print,format='(i4,e10.3,e10.3,e10.3)',result;
;
; iug_load_ionospheric_cond_part2, height_bottom=100, height_top=400, 
; height_step=10, glat=0, glon=0, yyyy=2000, mmdd=101, ltut=0,
; time=12, result=result
;-

pro iug_load_ionospheric_cond_part2_old, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result

; validate height_bottom
  if height_bottom lt 80 then begin
     dprint,"Satisfy this constraint 'height_bottom >= 80'."
;     dprint,"This procedure don't consider the cluster ion's influence under the altitude of 100km."
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

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse 
  
  height_array=fltarr(num_height)

  for i=0L,num_height-1 do begin
     height_array(i)=height_bottom+height_step*i
  endfor

; definition of physical constants 
  e_charge = 1.60217733E-19          ; (C)
  m_e = 9.1093817E-31                ; (kg)
  m_p = 1.6726231E-27                ; (kg)

; Calculation of IRI2012 model
  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

;
; Calculation of NRLMSISE for getting composition of atmosphere
;
  iug_load_nrlmsise00, yyyy=yyyy, mmdd=mmdd, height_bottom=height_bottom,height_top=height_top, height_step=height_step,time=time,glat=glat,glon=glon,result=result_msis

;
; IGRF11
; 
  iug_load_igrf11_array, height_bottom=height_bottom, height_top=height_top, height_step=height_step, yyyy=yyyy, glat=glat, glon=glon, r_d=r_d, r_i=r_i, r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f

;
; Calculation based on Kenichi Maeda's equation
;
  result = fltarr(7,num_height)

  for i=0L,num_height-1 do begin
     r_e=result_iri[5,i]/300.
     nu_en_perp=iug_collision_freq2_en_perp(r_e,result_msis[4,i]*1.E6,result_msis[5,i]*1.E6,result_msis[3,i]*1.E6)
     nu_en_para=iug_collision_freq2_en_para(r_e,result_msis[4,i]*1.E6,result_msis[5,i]*1.E6,result_msis[3,i]*1.E6)
     nu_ei_para=iug_collision_freq2_ei_para(result_iri[1,i]*1.E6,result_iri[5,i])

     r_i=(result_iri[3,i]+result_iri[4,i])/1000.
     nu_in=iug_collision_freq2_in(r_i,result_msis[4,i]*1.E6,result_msis[5,i]*1.E6, result_msis[3,i]*1.E6, result_iri[11,i]*1.E6, result_iri[10,i]*1.E6, result_iri[6,i]*1.E6)

; result[0,*]: simga_0, parallel conductivity
; result[1,*]: sigma_1, pedarsen conductivity
; result[2,*]: sigma_2, hole conductivity
; result[3,*]: simga_xx, parallel conductivity
; result[4,*]: sigma_yy, pedarsen conductivity
; result[5,*]: sigma_xy, hole conductivity
; result[6,*]: height

     num_o_p = result_iri[1,i]*1.E6*result_iri[6,i] /100.       ; O+
     num_n_p = result_iri[1,i]*1.E6*result_iri[7,i] /100.       ; N+
     num_h_p = result_iri[1,i]*1.E6*result_iri[8,i] /100.       ; H+
     num_he_p= result_iri[1,i]*1.E6*result_iri[9,i] /100.       ; He+
     num_o2_p= result_iri[1,i]*1.E6*result_iri[10,i]/100.       ; O2+
     num_no_p= result_iri[1,i]*1.E6*result_iri[11,i]/100.       ; NO+
     num_cluster_p = result_iri[1,i]*1.E6*result_iri[12,i]/100. ; Cluster+
     num_ions= result_iri[1,i]*1.E6 ; Ne/m-3

     m_i = ( 16.* num_o_p $
           + 14.* num_n_p $
           + 1. * num_h_p $
           + 4. * num_he_p $
           + 32.* num_o2_p $
           + 30.* num_no_p $
           + 82.* num_cluster_p) / num_ions * m_p

     omega_e = (e_charge*r_f[i]*1.E-9)/(m_e)
     omega_i = (e_charge*r_f[i]*1.E-9)/(m_i)

     result[0,i] = e_charge^2. * ( result_iri(1,i) * 1.E6 ) $
                   /( m_e * (nu_en_para+nu_ei_para) )
     result[1,i] = ( result_iri(1,i)*1.E6*e_charge/(r_f[i]*1.E-9) ) $
                   * ( (nu_in*omega_i)/(nu_in^2. +omega_i^2.)  $
                       + (nu_en_perp*omega_e)/(nu_en_perp^2. + omega_e^2.) )
     result[2,i] = ( result_iri(1,i)*1.E6*e_charge/(r_f[i]*1.E-9) ) $
                   * ( (omega_e^2.)/(nu_en_perp^2. +omega_e^2. ) $
                       + (omega_i^2.)/(nu_in^2. + omega_i^2. ) )
; 2 dimensional conductivity
     result[3,i] = ( result[0,i]*result[1,i] ) $
                 / ( result[1,i]*cos(!dpi/180.*r_i[i])^2. $
                   + result[0,i]*sin(!dpi/180.*r_i[i])^2. )
     result[4,i]=( result[0,i]*result[1,i]*sin(!dpi/180.*r_i[i])^2. $
                   + ( result[1,i]^2. + result[2,i]^2.) $
                   *cos(!dpi/180.*r_i[i])^2. ) $
                 /( result[1,i]*cos(!dpi/180.*r_i[i])^2. $
                    + result[0,i]*sin(!dpi/180.*r_i[i])^2. )
     result[5,i]=( result[0,i]*result[2,i]*sin(!dpi/180.*r_i[i])) $
                 /( result[1,i]*cos(!dpi/180.*r_i[i])^2. $
                   + result[0,i]*sin(!dpi/180.*r_i[i])^2. )
     result[6,i] = height_array[i]

  endfor

end
