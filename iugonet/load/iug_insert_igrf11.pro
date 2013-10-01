; docformat = 'IDL'

;+
;
;Name:
;IUG_CREATE_QUERY_IGRF11
;
;Purpose:
;To create query for iug_igrf11.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_create_query_igrf11,1,2000,0,0,100
;-
pro iug_insert_igrf11,coordinate_system,yyyy,glat,glon,height,d_ec,d_ecm,i_nc,i_ncm,h,x,y,z,f,d_sv,i_sv,h_sv,x_sv,y_sv,z_sv,f_sv
  openw,unit,'/tmp/iug_insert_igrf11.sql',/get_lun ; create query file
  printf,unit,'insert into iug_igrf11 values(',strtrim(string(coordinate_system),1),',',strtrim(string(yyyy),1),',',strtrim(string(glat),1),',',strtrim(string(glon),1),',',strtrim(string(height),1),',',strtrim(string(d_ec),1),',',strtrim(string(d_ecm),1),',',strtrim(string(i_nc),1),',',strtrim(string(i_ncm),1),',',strtrim(string(h),1),',',strtrim(string(x),1),',',strtrim(string(y),1),',',strtrim(string(z),1),',',strtrim(string(f),1),',',strtrim(string(d_sv),1),',',strtrim(string(i_sv),1),',',strtrim(string(h_sv),1),',',strtrim(string(x_sv),1),',',strtrim(string(y_sv),1),',',strtrim(string(z_sv),1),',',strtrim(string(f_sv),1),');'
  free_lun, unit

  spawn,'sqlite3 iug_igrf11.db < /tmp/iug_insert_igrf11.sql'
end
