; docformat = 'IDL'

;+
;NAME:
;
;EXAMPLE:
;
;-
pro iug_collision_freq1_in_reso,tn=tn,ti=ti,$
                                nh1=nh1,no1=no1,nn1=nn1,$
                                nhe=nhe,no2=no2,nn2=nn2,$
                                fh1_reso=fh1_reso,fo1_reso=fo1_reso,$
                                fn1_reso=fn1_reso,fhe_reso=fhe_reso,$
                                fo2_reso=fo2_reso,fn2_reso=fn2_reso
;
  fh1_reso=0. & fo1_reso=0. & fn1_reso=0. 
  fhe_reso=0. & fo2_reso=0. & fn2_reso=0.
  gamma = tn+ti
;  
  if gamma gt 100 then begin
     fh1_reso = 1.9E-12 * nh1  $
                * sqrt(gamma) * ( 14.4 - 1.17 * alog10(gamma) )^2.
  endif

  if gamma gt 470 then begin
     fo1_reso = 4.8E-13 * no1  $
                * sqrt(gamma) * ( 10.6 - 0.67 * alog10(gamma) )^2.
  endif

  if gamma gt 550 then begin
     fn1_reso = 5.2E-13 * nn1  $
                * sqrt(gamma) * ( 10.4 - 0.64 * alog10(gamma) )^2.
  endif

  if gamma gt 100 then begin
     fhe_reso= 9.7E-13 * nhe $
               * sqrt(gamma) * ( 11.6 - 1.05 * alog10(gamma) )^2.
  endif

  if gamma gt 1600 then begin
     fo2_reso= 3.4E-13 * no2 $
               * sqrt(gamma) * ( 10.6 - 0.76 * alog10(gamma) )^2.
  endif

  if gamma gt 340 then begin
     fn2_reso= 3.7E-13 * nn2 $
               * sqrt(gamma) * ( 14.3 - 0.96 * alog10(gamma) )^2.
  endif

end
