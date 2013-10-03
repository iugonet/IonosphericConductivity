; docformat = 'IDL'

;+
;
;Name:
;IUG_INSERT_IGRF11
;
;Purpose:
;To insert record iug_igrf11 in iug_igrf11.db
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
pro iug_insert_igrf11,coordinate_system=coordinate_system,yyyy=yyyy,glat=glat,glon=glon,height=height,d_ec=d_ec,d1_ecm=d1_ecm,i_nc=i_nc,i_ncm=i_ncm,h=h,x=x,y=y,z=z,f=f,d_sv=d_sv,i_sv=i_sv,h_sv=h_sv,x_sv=x_sv,y_sv=y_sv,z_sv=z_sv,f_sv=f_sv
  openw,unit,'/tmp/iug_insert_igrf11.sql',/get_lun ; create query file
  printf,unit,'insert into iug_igrf11 values(',strtrim(string(coordinate_system),1),',',strtrim(string(yyyy),1),',',strtrim(string(glat),1),',',strtrim(string(glon),1),',',strtrim(string(height),1),',',strtrim(string(d_ec),1),',',strtrim(string(d_ecm),1),',',strtrim(string(i_nc),1),',',strtrim(string(i_ncm),1),',',strtrim(string(h),1),',',strtrim(string(x),1),',',strtrim(string(y),1),',',strtrim(string(z),1),',',strtrim(string(f),1),',',strtrim(string(d_sv),1),',',strtrim(string(i_sv),1),',',strtrim(string(h_sv),1),',',strtrim(string(x_sv),1),',',strtrim(string(y_sv),1),',',strtrim(string(z_sv),1),',',strtrim(string(f_sv),1),');'
  free_lun, unit

  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/iug_igrf11.db < /tmp/iug_insert_igrf11.sql'
end
