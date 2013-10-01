; docformat = 'IDL'

;+
;
;Name:
;IUG_CHECK_IONOSPHERIC_COND_DB
;
;-

function iug_check_ionospheric_cond_db,height,glat,glon,yyyy,mmdd,ltut,atime,algorithm
  sigma_0 = 0. & sigma_1 = 0. & sigma_2 = 0.
  sigma_xx = 0. & sigma_yy = 0. & sigma_xy = 0.
;
  query = "SELECT sigma_0 FROM ionospheric_cond WHERE height="+string(height) $
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_0

  query = "SELECT sigma_1 FROM ionospheric_cond WHERE height="+string(height) $
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_1

  query = "SELECT sigma_2 FROM ionospheric_cond WHERE height="+string(height)$
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_2

  query = "SELECT sigma_xx FROM ionospheric_cond WHERE height="+string(height)$
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_xx

  query = "SELECT sigma_yy FROM ionospheric_cond WHERE height="+string(height)$
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_yy

  query = "SELECT sigma_xy FROM ionospheric_cond WHERE height="+string(height)$
          +" and glat="+string(glat)+" and glon="+string(glon) $
          +" and yyyy="+string(yyyy)+" and mmdd="+string(mmdd) $
          +" and ltut="+string(ltut)+" and atime="+string(atime) $
          +" and algorithm="+string(algorithm)
  spawn,'sqlite3 ionospheric_cond.db "'+query+'"',sigma_xy

  if strlen(sigma_0) ne 0 then begin
     return,{sigma_0:sigma_0,sigma_1:sigma_1,sigma_2:sigma_2,sigma_xx:sigma_xx,sigma_yy:sigma_yy,sigma_xy:sigma_xy}
  endif else begin
     return,{sigma_0:-1,sigma_1:-1,sigma_2:-1,sigma_xx:-1,sigma_yy:-1,sigma_xy:-1}
  endelse

end
