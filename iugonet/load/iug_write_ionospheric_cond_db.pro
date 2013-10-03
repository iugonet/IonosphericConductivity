; docformat = 'IDL'

;+
;
;Name:
;IUG_WRITE_IONOSPHERIC_COND_DB
;
;-

function iug_write_ionospheric_cond_db,height,glat,glon,yyyy,mmdd,ltut,atime,algorithm,sigma_0,sigma_1,sigma_2,sigma_xx,sigma_yy,sigma_xy
;
  query = "INSERT INTO ionospheric_cond VALUES ("+string(sigma_0) $
          +","+string(sigma_1)+","+string(sigma_2) $
          +","+string(sigma_xx)+","+string(sigma_yy) $
          +","+string(sigma_xy)+","+string(height) $
          +","+string(glat)+","+string(glon) $
          +","+string(yyyy)+","+string(mmdd) $
          +","+string(ltut)+","+string(atime) $
          +","+string(algorithm)+")"
  spawn,'sqlite3 ${UDASPLUS_HOME}/iugonet/load/ionospheric_cond.db "'+query+'"'

  return,0

end
