; docformat = 'IDL'

;+
;
;Name:
;IUG_HEIGHT_INTEGRATED_COND
;
;PURPOSE:
;To integrate the conductivity
;
;INPUTS:
;      Parm1: Describe the positional
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/24/2012
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_load_ionospheric_cond, height_bottom=100, height_top=120, $
;    height_step=10, glat=0, glon=0, yyyy=2000, mmdd=101, ltut=0, $
;    time=12, result=result
;  result2d = iug_height_integrated_cond(result)
;  print,result2d
;
;MODIFICATION HISTORY:
;      Yukinobu KOYAMA, 04/24/2012
;-
function iug_height_integrated_cond, cond_prof

  result = fltarr(6)
  nary = size(cond_prof)

; sigma0
  for i=0L,nary[2]-2 do begin
     result[0] = result[0] + (cond_prof[0,i+1]+cond_prof[0,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

; sigma1
  for i=0L,nary[2]-2 do begin
     result[1] = result[1] + (cond_prof[1,i+1]+cond_prof[1,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

; sigma2
  for i=0L,nary[2]-2 do begin
     result[2] = result[2] + (cond_prof[2,i+1]+cond_prof[2,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

; sigma_xx
  for i=0L,nary[2]-2 do begin
     result[3] = result[3] + (cond_prof[3,i+1]+cond_prof[3,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

; sigma_yy
  for i=0L,nary[2]-2 do begin
     result[4] = result[4] + (cond_prof[4,i+1]+cond_prof[4,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

; sigma_xy
  for i=0L,nary[2]-2 do begin
     result[5] = result[5] + (cond_prof[5,i+1]+cond_prof[5,i]) $
                 *(cond_prof[6,i+1]-cond_prof[6,i])*1.E3/2.
  endfor

  return, result

end
