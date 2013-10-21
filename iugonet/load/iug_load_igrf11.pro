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

pro iug_load_igrf11,height=height,yyyy=yyyy,glat=glat,glon=glon,r_d=r_d,r_i=r_i,r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f

; validate height
  if height lt 80 then begin
     dprint,"Satisfy 'height >=80 (km)'."
     return
  endif
; validate height
  if height gt 2000 then begin
     dprint,"Satisfy 'height < 2000 (km)'."
  endif

;
  tmp_dir = '/tmp/'+string(iug_getpid(),format='(i0)')+'/'
  result_file_test = file_test(tmp_dir)
  if file_test(tmp_dir) eq 0 then begin 
     file_mkdir, tmp_dir
  endif

;;;
  iug_create_query_igrf11,coordinate_system=1,yyyy=yyyy,glat=glat,glon=glon,height=height
  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/igrf11.db < '+tmp_dir+'igrf11.sql'
  query_result=file_info(tmp_dir+'igrf11.result')

  if query_result.size eq 0 then begin                ; calculate by using model
;
     openw, unit, tmp_dir+'igrf11.input', /get_lun ; create input file
     printf,unit,'result.txt'                      ; Enter name of output file (30 characters maximum)
     printf,unit,1                                 ; 1 - geodetic (shape of Earth is approximated by a spheroid)
                                ; 2 - geocentric (shape of Earth is approximated by a shere)
     printf,unit,1              ; 1 - values at one or more locations & dates
                                ; 2 - values at yearly intervals at one location
                                ; 3 - values on a latitude/longitude grid at one date
     printf,unit,2              ; 1 - in degrees & minutes, 2 - in decimal degrees
     printf,unit,yyyy           ; years A.D.
     printf,unit,height         ; altitude in km
     printf,unit,glat           ; latitude in decimal degrees
     printf,unit,glon           ; longitude in decimal degrees
     printf,unit,''             ; place name (20 characters maximum)
     printf,unit,'n'            ; Do you want values for another date & position?
     free_lun, unit

     spawn,'cd ${HOME}/IAGA/vmod; rm result.txt ; rm result2.txt; ./a.out < '+tmp_dir+'igrf11.input'
     spawn,"cat ${HOME}/IAGA/vmod/result.txt | awk '{if( NR>1 && NR<4){printf(""%6d%6d%6d\n"",$3,$5,$9)}else if( NR>3 && NR<9){printf(""%6d%6d\n"",$3,$7)}}' > ${HOME}/IAGA/vmod/result2.txt"

     openr, unit, '${HOME}/IAGA/vmod/result2.txt', /get_lun
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
        r_d=temp0_0+temp0_1/60. ; D
     endif
     if( temp0_0<0 ) then begin
        r_d=temp0_0-temp0_1/60. ; D
     endif
     if( temp1_0>0 ) then begin
        r_i=temp1_0+temp1_1/60. ; I
     endif
     if( temp1_0<0 ) then begin
        r_i=temp1_0-temp1_1/60. ; I
     endif
     r_h=temp2               ; H
     r_x=temp3               ; X
     r_y=temp4               ; Y
     r_z=temp5               ; Z
     r_f=temp6               ; F
     free_lun, unit
;
     iug_insert_igrf11,coordinate_system=1,yyyy=yyyy,glat=glat,glon=glon,height=height,d_deg=temp0_0,d_min=temp0_1,i_deg=temp1_0,i_min=temp1_1,r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f,d_sv=temp7,i_sv=temp8,h_sv=temp9,x_sv=temp10,y_sv=temp11,z_sv=temp12,f_sv=temp13
;
  endif else begin              ; retrieve from DB                             
     openr, unit, tmp_dir+'igrf11.result', /get_lun
     array=fltarr(21)
     readf,unit,array
     
     temp0_0 = array(5)
     temp0_1 = array(6)
     temp1_0 = array(7)
     temp1_1 = array(8)
     
     if( temp0_0>0 ) then begin
        r_d=temp0_0+temp0_1/60. ; D
     endif
     if( temp0_0<0 ) then begin
        r_d=temp0_0-temp0_1/60. ; D
     endif
     if( temp1_0>0 ) then begin
        r_i=temp1_0+temp1_1/60. ; I
     endif
     if( temp1_0<0 ) then begin
        r_i=temp1_0-temp1_1/60. ; I
     endif
     r_h = array(9)
     r_x = array(10)
     r_y = array(11)
     r_z = array(12)
     r_f = array(13)
     free_lun, unit
  endelse

end
