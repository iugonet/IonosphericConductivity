; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IGRF11
;
;Purpose:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 04/25/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
;  iug_load_igrf11,height_bottom=100,height_top=120,height_step=10,yyyy=2000,glat=0,glon=0,result_d=result_d,result_i=result_i,result_h=result_h,result_x=result_x,result_y=result_y,result_z=result_z,result_f=result_f
;  print,result_h,result_d,result_z,result_f
;  print,result_x,result_y,result_z,result_f
;
;-

pro iug_load_igrf11,height_bottom=height_bottom,height_top=height_top,height_step=height_step,yyyy=yyyy,glat=glat,glon=glon,result_d=result_d,result_i=result_i,result_h=result_h,result_x=result_x,result_y=result_y,result_z=result_z,result_f=result_f

  if height_top ne height_bottom then begin
     num_height = (height_top-height_bottom)/height_step+1
  endif else begin
     num_height = 1
  endelse

  result_d = fltarr(num_height)
  result_i = fltarr(num_height)
  result_h = fltarr(num_height)
  result_x = fltarr(num_height)
  result_y = fltarr(num_height)
  result_z = fltarr(num_height)
  result_f = fltarr(num_height)

  for i=0L,num_height-1 do begin
;;;
     height=height_bottom+height_step*i
     iug_create_query_igrf11,1,yyyy,glat,glon,height
     spawn,'sqlite3 -separator " " iug_igrf11.db < /tmp/iug_igrf11_query.sql > /tmp/tmp.txt'
     result=file_info('/tmp/tmp.txt')

     if result.size eq 0 then begin ; calculate by using model               
;;;
        openw,unit,'/tmp/input_igrf11.txt',/get_lun ; create input file
        printf,unit,'result.txt' ; Enter name of output file (30 characters maximum)
        printf,unit,1 ; 1 - geodetic (shape of Earth is approximated by a spheroid)
                  ; 2 - geocentric (shape of Earth is approximated by a shere)
        printf,unit,1     ; 1 - values at one or more locations & dates
                                ; 2 - values at yearly intervals at one location
                                ; 3 - values on a latitude/longitude grid at one date
        printf,unit,2        ; 1 - in degrees & minutes, 2 - in decimal degrees
        printf,unit,yyyy     ; years A.D.
        printf,unit,height_bottom+height_step*i ; altitude in km
        printf,unit,glat                        ; latitude in decimal degrees
        printf,unit,glon                        ; longitude in decimal degrees
        printf,unit,''        ; place name (20 characters maximum)
        printf,unit,'n'       ; Do you want values for another date & position?
        free_lun, unit

        spawn,'cd ${HOME}/IAGA/vmod; rm result.txt ; rm result2.txt; ./a.out < /tmp/input_igrf11.txt'
        spawn,"cat ${HOME}/IAGA/vmod/result.txt | awk '{if( NR>1 && NR<4){printf(""%6d%6d%6d\n"",$3,$5,$9)}else if( NR>3 && NR<9){printf(""%6d%6d\n"",$3,$7)}}' > ${HOME}/IAGA/vmod/result2.txt"

        openr,unit, '${HOME}/IAGA/vmod/result2.txt', /GET_LUN
        temp0_0='' & temp0_1=''
        temp1_0='' & temp1_1=''
        temp2='' & temp3='' & temp4='' & temp5='' & temp6=''
        temp7='' & temp8='' & temp9='' & temp10='' & temp11=''
        temp12='' & temp13=''

        readf,unit,format='(a6,a6,a6)',temp0_0,temp0_1,temp7
        readf,unit,format='(a6,a6,a6)',temp1_0,temp1_1,temp8
        readf,unit,format='(a6,a6)',temp2,temp9
        readf,unit,format='(a6,a6)',temp3,temp10
        readf,unit,format='(a6,a6)',temp4,temp11
        readf,unit,format='(a6,a6)',temp5,temp12
        readf,unit,format='(a6,a6)',temp6,temp13
        if( temp0_0>0 ) then begin
           result_d[i]=temp0_0+temp0_1/60. ; D
        endif
        if( temp0_0<0 ) then begin
           result_d[i]=temp0_0-temp0_1/60. ; D
        endif
        if( temp1_0>0 ) then begin
           result_i[i]=temp1_0+temp1_1/60. ; I
        endif
        if( temp1_0<0 ) then begin
           result_i[i]=temp1_0-temp1_1/60. ; I
        endif
        result_h[i]=temp2       ; H
        result_x[i]=temp3       ; X
        result_y[i]=temp4       ; Y
        result_z[i]=temp5       ; Z
        result_f[i]=temp6       ; F
        free_lun, unit
;
        iug_insert_igrf11,1,yyyy,glat,glon,height,temp0_0,temp0_1,temp1_0,temp1_1,result_h[i],result_x[i],result_y[i],result_z[i],result_f[i],temp7,temp8,temp9,temp10,temp11,temp12,temp13
;
     endif else begin           ; retrieve from DB                             
        openr, unit, '/tmp/tmp.txt', /GET_LUN
        array=fltarr(21)
        readf,unit,array

        temp0_0 = array(5)
        temp0_1 = array(6)
        temp1_0 = array(7)
        temp1_1 = array(8)

        if( temp0_0>0 ) then begin
           result_d[i]=temp0_0+temp0_1/60. ; D
        endif
        if( temp0_0<0 ) then begin
           result_d[i]=temp0_0-temp0_1/60. ; D
        endif
        if( temp1_0>0 ) then begin
           result_i[i]=temp1_0+temp1_1/60. ; I
        endif
        if( temp1_0<0 ) then begin
           result_i[i]=temp1_0-temp1_1/60. ; I
        endif
        result_h[i] = array(9)
        result_x[i] = array(10)
        result_y[i] = array(11)
        result_z[i] = array(12)
        result_f[i] = array(13)
        free_lun, unit
     endelse
  endfor

end
