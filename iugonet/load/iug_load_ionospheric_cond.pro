; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND
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
; iug_load_ionospheric_cond, height_bottom=100, height_top=400, height_step=10,
; glat=0, glon=0, yyyy=2000, mmdd=101, ltut=0, time=12, algorithm=1,
; result=result
;
; iug_load_ionospheric_cond, height_bottom=100, height_top=400, height_step=10,
; glat=0, glon=0, yyyy=2000, mmdd=101, ltut=0, time=12, algorithm=2,
; result=result
;-

pro iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, algorithm=algorithm, result=result

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
; validate algorithm
  if algorithm ne 1 and algorithm ne 2 then begin
     dprint,"Specify algorithm correctly."
     dprint,"Collision frequency is calculated by ..."
     dprint,"   1: Banks, P. M., G. Kocharts, Aeronomy pt. A. - Academic Press, 1973"
     dprint,"   2: Haris Volland, Handbook of ATMOSPHERIC ELECTORODYNAMICS, Volume II, CRC Press, 1995."
     return
  endif
;
  if algorithm eq 1 then begin
     iug_load_ionospheric_cond_part1, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result
  endif
  if algorithm eq 2 then begin
     iug_load_ionospheric_cond_part2, height_bottom=height_bottom, height_top=height_top, height_step=height_step, glat=glat, glon=glon, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, result=result
  endif

end
