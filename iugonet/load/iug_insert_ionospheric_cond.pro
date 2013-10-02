; docformat = 'IDL'

;+
;
;Name:
;IUG_INSERT_IONOSPHERIC_COND
;
;Purpose:
;To insert record iug_ionospheric_cond in iug_ionospheric_cond.db
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/01/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  iug_insert_ionospheric_cond
;-
pro iug_insert_ionospheric_cond,sigma_0=sigma_0,sigma_1=sigma_1,sigma_2=sigma_2,sigma_xx=sigma_xx,sigma_yy=sigma_yy,sigma_xy=sigma_xy,height=height,glat=glat,glon=glon,yyyy=yyyy,mmdd=mmdd,ltut=ltut,atime=atime,algorithm=algorithm
  openw,unit,'/tmp/iug_insert_ionospheric_cond.sql',/get_lun ; create query file
  printf,unit,'insert into iug_ionospheric_cond values(',strtrim(string(sigma_0),1),',',strtrim(string(sigma_1),1),',',strtrim(string(sigma_2),1),',',strtrim(string(sigma_xx),1),',',strtrim(string(sigma_yy),1),',',strtrim(string(sigma_xy),1),',',strtrim(string(height),1),',',strtrim(string(glat),1),',',strtrim(string(glon),1),',',strtrim(string(yyyy),1),',',strtrim(string(mmdd),1),',',strtrim(string(ltut),1),',',strtrim(string(atime),1),',',strtrim(string(algorithm),1),');'
  free_lun, unit

  spawn,'sqlite3 iug_ionospheric_cond.db < /tmp/iug_insert_ionospheric_cond.sql'
end
