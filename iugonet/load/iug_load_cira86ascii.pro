; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_CIRA86ASCII
;
;Purpose:
;
;
;Syntax:
;
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 9/7/2011.
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_load_cira86ascii, month=1,
;datatype="pressure",filetype="twp",result=result
; height=result[0,*]
; pressure=result[1,*]
; plot,height,pressure,xtitle="height (km)",ytitle="pressure (hPa)"
;-

compile_opt idl2

pro iug_load_cira86ascii, result=result, $ 
  month=month, $                   
  verbose=verbose, $
  filetype=filetype, $
  datatype=datatype ; Input/output -- will clean inputs or show default.

;*******************
;VERBOSE kw default:
;*******************
if ~keyword_set(verbose) then verbose=2

;******************************
;Load 'twp' data by default:
;******************************
if ~keyword_set(filetype) then filetype='twp'

;*******************
;Validate datatypes:
;*******************

if ~size(fns,/type) then begin
   ;Get files and local paths, and concatenate local paths:
   ;=======================================================
   height='' 
   s80='' & s70='' & s60='' & s50='' & s40='' & s30='' & s20='' & s10=''
   equ=''
   n10='' & n20='' & n30='' & n40='' & n50='' & n60='' & n70='' & n80=''
   dummy=''
;   temperature=fltarr(17) & temperature[*]=0.0
;   wind=fltarr(17) & wind[*]=0.0
;   pressure=fltarr(17) & pressure[*]=0.0
   exponent=''
; ZONAL MEAN TEMPERATURE

   if datatype eq "temperature" then begin
      openr, unit, '${HOME}/models/atmospheric/cira/cira86ascii/twp.lsn', /get_lun
      if month eq 1 then begin  ; Jan
         starts_at_line=7
         ends_at_line=31
      endif 
      if month eq 2 then begin  ; Feb
         starts_at_line=99
         ends_at_line=123
      endif
      if month eq 3 then begin  ; Mar
         starts_at_line=191
         ends_at_line=215
      endif
      if month eq 4 then begin  ; Apr
         starts_at_line=283
         ends_at_line=307
      endif
      if month eq 5 then begin  ; May
         starts_at_line=375
         ends_at_line=399
      endif
      if month  eq 6 then begin ;Jun
         starts_at_line=467
         ends_at_line=491
      endif
      if month eq 7 then begin  ; Jul
         starts_at_line=559
         ends_at_line=583
      endif
      if month eq 8 then begin  ; Aug
         starts_at_line=651
         ends_at_line=675
      endif
      if month eq 9 then begin  ; Sep
         starts_at_line=743
         ends_at_line=767
      endif
      if month eq 10 then begin ; Oct
         starts_at_line=835
         ends_at_line=859
      endif
      if month eq 11 then begin ; Nov
         starts_at_line=927
         ends_at_line=951
      endif
      if month eq 12 then begin ; Dec
         starts_at_line=1019
         ends_at_line=1043
      endif

      result = fltarr(18,ends_at_line-starts_at_line+1)
      
      skip_lun, unit, starts_at_line-1, /lines
      for i=0L,ends_at_line-starts_at_line do begin
         readf,unit,format='(a4,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7)',height,s80,s70,s60,s50,s40,s30,s20,s10,equ,n10,n20,n30,n40,n50,n60,n70,n80
;         readf,unit,format='(a4,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7)',height,temperature[0],temperature[1],temperature[2],temperature[3],temperature[4],temperature[5],temperature[6],temperature[7],temperature[8],temperature[9],temperature[10],temperature[11],temperature[12],temperature[13],temperature[14],temperature[15],temperature[16]
         result[0,i]=height
         if s80 eq 0.0 then begin
;         if temperature[0] eq 0.0 then begin
            result[1,i]=!values.f_nan
         endif else begin
           result[1,i]=s80
;           result[1,i]=temperature[0]
         endelse

         if s70 eq 0.0 then begin
;         if temperature[1] eq 0.0 then begin
            result[2,i]=!values.f_nan
         endif else begin
            result[2,i]=s70
;            result[2,i]=temperature[1]
         endelse

         if s60 eq 0.0 then begin
;         if temperature[2] eq 0.0 then begin
            result[3,i]=!values.f_nan
         endif else begin
            result[3,i]=s60
;            result[3,i]=temperature[2]
         endelse

         if s50 eq 0.0 then begin
;         if temperature[3] eq 0.0 then begin
            result[4,i]=!values.f_nan
         endif else begin
            result[4,i]=s50
;            result[4,i]=temperature[3]
         endelse

         if s40 eq 0.0 then begin
;         if temperature[4] eq 0.0 then begin
            result[5,i]=!values.f_nan
         endif else begin
            result[5,i]=s40
;            result[5,i]=temperature[4]
         endelse

         if s30 eq 0.0 then begin
;         if temperature[5] eq 0.0 then begin
            result[6,i]=!values.f_nan
         endif else begin
            result[6,i]=s30
;            result[6,i]=temperature[5]
         endelse

         if s20 eq 0.0 then begin
;         if temperature[6] eq 0.0 then begin
            result[7,i]=!values.f_nan
         endif else begin
            result[7,i]=s20
;            result[7,i]=temperature[6]
         endelse

         if s10 eq 0.0 then begin
;         if temperature[7] eq 0.0 then begin
            result[8,i]=!values.f_nan
         endif else begin
            result[8,i]=s10
;            result[8,i]=temperature[7]
         endelse

         if equ eq 0.0 then begin
;         if temperature[8] eq 0.0 then begin
            result[9,i]=!values.f_nan
         endif else begin
            result[9,i]=equ
;            result[9,i]=temperature[8]
         endelse

         if n10 eq 0.0 then begin
;         if temperature[9] eq 0.0 then begin
            result[10,i]=!values.f_nan
         endif else begin
            result[10,i]=n10
;            result[10,i]=temperature[9]
         endelse

         if n20 eq 0.0 then begin
;         if temperature[10] eq 0.0 then begin
            result[11,i]=!values.f_nan
         endif else begin
            result[11,i]=n20
;            result[11,i]=temperature[10]
         endelse

         if n30 eq 0.0 then begin
;         if temperature[11] eq 0.0 then begin
            result[12,i]=!values.f_nan
         endif else begin
            result[12,i]=n30
;            result[12,i]=temperature[11]
         endelse

         if n40 eq 0.0 then begin
;         if temperature[12] eq 0.0 then begin
            result[13,i]=!values.f_nan
         endif else begin
            result[13,i]=n40
;            result[13,i]=temperature[12]
         endelse

         if n50 eq 0.0 then begin
;         if temperature[13] eq 0.0 then begin
            result[14,i]=!values.f_nan
         endif else begin
            result[14,i]=n50
;            result[14,i]=temperature[13]
         endelse

         if n60 eq 0.0 then begin
;         if temperature[14] eq 0.0 then begin
            result[15,i]=!values.f_nan
         endif else begin
            result[15,i]=n60
;            result[15,i]=temperature[14]
         endelse

         if n70 eq 0.0 then begin
;         if temperature[15] eq 0.0 then begin
            result[16,i]=!values.f_nan
         endif else begin
            result[16,i]=n70
;            result[16,i]=temperature[15]
         endelse

         if n80 eq 0.0 then begin
;         if temperature[16] eq 0.0 then begin
            result[17,i]=!values.f_nan
         endif else begin
            result[17,i]=n80
;            result[17,i]=temperature[16]
         endelse
      endfor
      free_lun, unit 
   endif

; ZONAL MEAN ZONAL WIND
   if datatype eq "wind" then begin
      openr, unit, '${HOME}/models/atmospheric/cira/cira86ascii/twp.lsn', /get_lun
      if month eq 1 then begin  ; Jan
         starts_at_line=39
         ends_at_line=63
      endif
      if month eq 2 then begin  ; Feb
         starts_at_line=131
         ends_at_line=155
      endif
      if month eq 3 then begin  ; Mar
         starts_at_line=223
         ends_at_line=247
      endif
      if month eq 4 then begin  ; Apr
         starts_at_line=315
         ends_at_line=339
      endif
      if month eq 5 then begin  ; May
         starts_at_line=407
         ends_at_line=431
      endif
      if month  eq 6 then begin ;Jun
         starts_at_line=499
         ends_at_line=523
      endif
      if month eq 7 then begin  ; Jul
         starts_at_line=591
         ends_at_line=615
      endif
      if month eq 8 then begin  ; Aug
         starts_at_line=683
         ends_at_line=707
      endif
      if month eq 9 then begin  ; Sep
         starts_at_line=775
         ends_at_line=799
      endif
      if month eq 10 then begin ; Oct
         starts_at_line=867
         ends_at_line=891
      endif
      if month eq 11 then begin ; Nov
         starts_at_line=959
         ends_at_line=983
      endif
      if month eq 12 then begin ; Dec
         starts_at_line=1051
         ends_at_line=1075
      endif
   
      result = fltarr(18,ends_at_line-starts_at_line+1)

      skip_lun, unit, starts_at_line-1, /lines
      for i=0L,ends_at_line-starts_at_line do begin
         readf,unit,format='(a4,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7)',height,s80,s70,s60,s50,s40,s30,s20,s10,equ,n10,n20,n30,n40,n50,n60,n70,n80
;         readf,unit,format='(a4,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7)',height,wind[0],wind[1],wind[2],wind[3],wind[4],wind[5],wind[6],wind[7],wind[8],wind[9],wind[10],wind[11],wind[12],wind[13],wind[14],wind[15],wind[16]

         result[0,i]=height
         if s80 eq 0.0 then begin
;         if wind[1] eq 0.0 then begin
            result[1,i]=!values.f_nan
         endif else begin
            result[1,i]=s80
;            result[1,i]=wind[1]
         endelse

         if s70 eq 0.0 then begin
;         if wind[2] eq 0.0 then begin
            result[2,i]=!values.f_nan
         endif else begin
            result[2,i]=s70
;            result[2,i]=wind[2]
         endelse

         if s60 eq 0.0 then begin
;         if wind[3] eq 0.0 then begin
            result[3,i]=!values.f_nan
         endif else begin
            result[3,i]=s60
;            result[3,i]=wind[3]
         endelse

         if s50 eq 0.0 then begin
;         if wind[4] eq 0.0 then begin
            result[4,i]=!values.f_nan
         endif else begin
            result[4,i]=s50
;            result[4,i]=wind[4]
         endelse

         if s40 eq 0.0 then begin
;         if wind[5] eq 0.0 then begin
            result[5,i]=!values.f_nan
         endif else begin
            result[5,i]=s40
;            result[5,i]=wind[5]
         endelse

         if s30 eq 0.0 then begin
;         if wind[6] eq 0.0 then begin
            result[6,i]=!values.f_nan
         endif else begin
            result[6,i]=s30
;            result[6,i]=wind[6]
         endelse

         if s20 eq 0.0 then begin
;         if wind[7] eq 0.0 then begin
            result[7,i]=!values.f_nan
         endif else begin
            result[7,i]=s20
;            result[7,i]=wind[7]
         endelse

         if s10 eq 0.0 then begin
;         if wind[8] eq 0.0 then begin
            result[8,i]=!values.f_nan
         endif else begin
            result[8,i]=s10
;            result[8,i]=wind[8]
         endelse

         if equ eq 0.0 then begin
;         if wind[9] eq 0.0 then begin
            result[9,i]=!values.f_nan
         endif else begin
            result[9,i]=equ
;            result[9,i]=wind[9]
         endelse

         if n10 eq 0.0 then begin
;         if wind[10] eq 0.0 then begin
            result[10,i]=!values.f_nan
         endif else begin
            result[10,i]=n10
;            result[10,i]=wind[10]
         endelse

         if n20 eq 0.0 then begin
;         if wind[11] eq 0.0 then begin
            result[11,i]=!values.f_nan
         endif else begin
            result[11,i]=n20
;            result[11,i]=wind[11]
         endelse

         if n30 eq 0.0 then begin
;         if wind[12] eq 0.0 then begin
            result[12,i]=!values.f_nan
         endif else begin
            result[12,i]=n30
;            result[12,i]=wind[12]
         endelse

         if n40 eq 0.0 then begin
;         if wind[13] eq 0.0 then begin
            result[13,i]=!values.f_nan
         endif else begin
            result[13,i]=n40
;            result[13,i]=wind[13]
         endelse

         if n50 eq 0.0 then begin
;         if wind[14] eq 0.0 then begin
            result[14,i]=!values.f_nan
         endif else begin
            result[14,i]=n50
;            result[14,i]=wind[14]
         endelse

         if n60 eq 0.0 then begin
;         if wind[15] eq 0.0 then begin
            result[15,i]=!values.f_nan
         endif else begin
            result[15,i]=n60
;            result[15,i]=wind[15]
         endelse

         if n70 eq 0.0 then begin
;         if wind[16] eq 0.0 then begin
            result[16,i]=!values.f_nan
         endif else begin
            result[16,i]=n70
;            result[16,i]=wind[16]
         endelse

         if n80 eq 0.0 then begin
;         if wind[17] eq 0.0 then begin
            result[17,i]=!values.f_nan
         endif else begin
            result[17,i]=n80
;            result[17,i]=wind[17]
         endelse
      endfor
      free_lun, unit 
   endif

; ZONAL MEAN PRESSURE
   if datatype eq "pressure" then begin
      openr, unit, '${HOME}/models/atmospheric/cira/cira86ascii/twp.lsn', /get_lun
      if month eq 1 then begin  ; Jan
         starts_at_line=71
         ends_at_line=91
      endif 
      if month eq 2 then begin  ; Feb
         starts_at_line=163
         ends_at_line=183
      endif
      if month eq 3 then begin  ; Mar
         starts_at_line=255
         ends_at_line=275
      endif
      if month eq 4 then begin  ; Apr
         starts_at_line=347
         ends_at_line=367
      endif
      if month eq 5 then begin  ; May
         starts_at_line=439
         ends_at_line=459
      endif
      if month  eq 6 then begin ;Jun
         starts_at_line=531
         ends_at_line=551
      endif
      if month eq 7 then begin  ; Jul
         starts_at_line=623
         ends_at_line=643
      endif
      if month eq 8 then begin  ; Aug
         starts_at_line=715
         ends_at_line=735
      endif
      if month eq 9 then begin  ; Sep
         starts_at_line=807
         ends_at_line=827
      endif
      if month eq 10 then begin ; Oct
         starts_at_line=899
         ends_at_line=919
      endif
      if month eq 11 then begin ; Nov
         starts_at_line=991
         ends_at_line=1011
      endif
      if month eq 12 then begin ; Dec
         starts_at_line=1083
         ends_at_line=1103
      endif

      result = fltarr(20,ends_at_line-starts_at_line+1)
      
      skip_lun, unit, starts_at_line-1, /lines
      for i=0L,ends_at_line-starts_at_line do begin
         readf,unit,format='(a4,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a7,a5,a2)',height,s80,s70,s60,s50,s40,s30,s20,s10,equ,n10,n20,n30,n40,n50,n60,n70,n80,dummy,exponent
         s80=s80*10^exponent
         s70=s70*10^exponent
         s60=s60*10^exponent
         s50=s50*10^exponent
         s40=s40*10^exponent
         s30=s30*10^exponent
         s20=s20*10^exponent
         s10=s10*10^exponent
         equ=equ*10^exponent
         n10=n10*10^exponent
         n20=n20*10^exponent
         n30=n30*10^exponent
         n40=n40*10^exponent
         n50=n50*10^exponent
         n60=n60*10^exponent
         n70=n70*10^exponent
         n80=n80*10^exponent
;         pressure=pressure*10^exponent

         result[0,i]=height
         if s80 eq 0.0 then begin
;         if pressure[0] eq 0.0 then begin
            result[1,i]=!values.f_nan
         endif else begin
            result[1,i]=s80
;            result[1,i]=pressure[0]
         endelse

         if s70 eq 0.0 then begin
;         if pressure[1] eq 0.0 then begin
            result[2,i]=!values.f_nan
         endif else begin
            result[2,i]=s70
;            result[2,i]=pressure[1]
         endelse

         if s60 eq 0.0 then begin
;         if pressure[2] eq 0.0 then begin
            result[3,i]=!values.f_nan
         endif else begin
            result[3,i]=s60
;            result[3,i]=pressure[2]
         endelse

         if s50 eq 0.0 then begin
;         if pressure[3] eq 0.0 then begin
            result[4,i]=!values.f_nan
         endif else begin
            result[4,i]=s50
;            result[4,i]=pressure[3]
         endelse

         if s40 eq 0.0 then begin
;         if pressure[4] eq 0.0 then begin
            result[5,i]=!values.f_nan
         endif else begin
            result[5,i]=s40
;            result[5,i]=pressure[4]
         endelse

         if s30 eq 0.0 then begin
;         if pressure[5] eq 0.0 then begin
            result[6,i]=!values.f_nan
         endif else begin
            result[6,i]=s30
;            result[6,i]=pressure[5]
         endelse

         if s20 eq 0.0 then begin
;         if pressure[6] eq 0.0 then begin
            result[7,i]=!values.f_nan
         endif else begin
            result[7,i]=s20
;            result[7,i]=pressure[6]
         endelse

         if s10 eq 0.0 then begin
;         if pressure[7] eq 0.0 then begin
            result[8,i]=!values.f_nan
         endif else begin
            result[8,i]=s10
;            result[8,i]=pressure[7]
         endelse

         if equ eq 0.0 then begin
;         if pressure[8] eq 0.0 then begin
            result[9,i]=!values.f_nan
         endif else begin
            result[9,i]=equ
;            result[9,i]=pressure[8]
         endelse

         if n10 eq 0.0 then begin
;         if pressure[9] eq 0.0 then begin
            result[10,i]=!values.f_nan
         endif else begin
            result[10,i]=n10
;            result[10,i]=pressure[9]
         endelse

         if n20 eq 0.0 then begin
;         if pressure[10] eq 0.0 then begin
            result[11,i]=!values.f_nan
         endif else begin
            result[11,i]=n20
;            result[11,i]=pressure[10]
         endelse

         if n30 eq 0.0 then begin
;         if pressure[11] eq 0.0 then begin
            result[12,i]=!values.f_nan
         endif else begin
            result[12,i]=n30
;            result[12,i]=pressure[11]
         endelse

         if n40 eq 0.0 then begin
;         if pressure[12] eq 0.0 then begin
            result[13,i]=!values.f_nan
         endif else begin
            result[13,i]=n40
;            result[13,i]=pressure[12]
         endelse

         if n50 eq 0.0 then begin
;         if pressure[13] eq 0.0 then begin
            result[14,i]=!values.f_nan
         endif else begin
            result[14,i]=n50
;            result[14,i]=pressure[13]
         endelse

         if n60 eq 0.0 then begin
;         if pressure[14] eq 0.0 then begin
            result[15,i]=!values.f_nan
         endif else begin
            result[15,i]=n60
;            result[15,i]=pressure[14]
         endelse

         if n70 eq 0.0 then begin
;         if pressure[15] eq 0.0 then begin
            result[16,i]=!values.f_nan
         endif else begin
            result[16,i]=n70
;            result[16,i]=pressure[15]
         endelse

         if n80 eq 0.0 then begin
;         if pressure[16] eq 0.0 then begin
            result[17,i]=!values.f_nan
         endif else begin
            result[17,i]=n80
;            result[17,i]=pressure[16]
         endelse
      endfor
      free_lun, unit 
   endif

endif else file_names=fns

;Read the files:
;===============

;Store data in variables:
;========================
nhant=0 & nhanw=0 & nhanz=0 & nht=0 & nhw=0 & nhz=0 
shant=0 & shanw=0 & sht=0 & shw=0 & shz=0 & twp=1

;
if keyword_set(nhant) then begin
   
endif
;
if keyword_set(nhanw) then begin

endif
;
if keyword_set(nhanz) then begin

endif
;
if keyword_set(nht) then begin

endif
;
if keyword_set(nhw) then begin

endif
;
if keyword_set(nhz) then begin

endif
;
if keyword_set(shant) then begin

endif
;
if keyword_set(shanw) then begin

endif
;
if keyword_set(sht) then begin

endif
;
if keyword_set(shw) then begin

endif
;
if keyword_set(shz) then begin

endif

print,'********************************************************************************'
print, 'CIRA86 are provided by the '
print,'********************************************************************************'

return
end
