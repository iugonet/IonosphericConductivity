; docformat = 'IDL'

;+
;
;Name:
;IUG_INSERT_IGRF11
;
;Purpose:
;To insert record igrf11 in igrf11.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_insert_igrf11
;-
pro iug_insert_igrf11,coordinate_system=coordinate_system,yyyy=yyyy,glat=glat,glon=glon,height=height,d_deg=d_deg,d_min=d_min,i_deg=i_deg,i_min=i_min,r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f,d_sv=d_sv,i_sv=i_sv,h_sv=h_sv,x_sv=x_sv,y_sv=y_sv,z_sv=z_sv,f_sv=f_sv
  openw,unit,'/tmp/iug_insert_igrf11.sql',/get_lun ; create query file
  printf,unit,'insert into igrf11 values(',strtrim(string(coordinate_system),1),',',strtrim(string(yyyy),1),',',strtrim(string(glat),1),',',strtrim(string(glon),1),',',strtrim(string(height),1),',',strtrim(string(d_deg),1),',',strtrim(string(d_min),1),',',strtrim(string(i_deg),1),',',strtrim(string(i_min),1),',',strtrim(string(r_h),1),',',strtrim(string(r_x),1),',',strtrim(string(r_y),1),',',strtrim(string(r_z),1),',',strtrim(string(r_f),1),',',strtrim(string(d_sv),1),',',strtrim(string(i_sv),1),',',strtrim(string(h_sv),1),',',strtrim(string(x_sv),1),',',strtrim(string(y_sv),1),',',strtrim(string(z_sv),1),',',strtrim(string(f_sv),1),');'
  free_lun, unit

  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/igrf11.db < /tmp/iug_insert_igrf11.sql'
end
