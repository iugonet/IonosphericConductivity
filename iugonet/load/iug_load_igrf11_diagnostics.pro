pro iug_load_igrf11_diagnostics
  ; initialize
  spawn,'mv iug_igrf11.db iug_igrf11.db.tmp' ; escape for testing
  spawn,'sqlite3 iug_igrf11.db < iug_igrf11.sql'

  ; main
  height_bottom=100
  height_top=100
  height_step=0
  yyyy=2000
  glat=0
  glon=0
  iug_load_igrf11,height_bottom=height_bottom,height_top=height_top,height_step=height_step,yyyy=yyyy,glat=glat,glon=glon,result_d=result_d,result_i=result_i,result_h=result_h,result_x=result_x,result_y=result_y,result_z=result_z,result_f=result_f

  ; retrieved the cached data from DB
  iug_load_igrf11,height_bottom=height_bottom,height_top=height_top,height_step=height_step,yyyy=yyyy,glat=glat,glon=glon,result_d=result_d,result_i=result_i,result_h=result_h,result_x=result_x,result_y=result_y,result_z=result_z,result_f=result_f

  print,"expected, actual"
  print,'-7 deg 21min',result_d
  print,'-27 deg 25min',result_i
  print,'26347',result_h
  print,'26130',result_x
  print,'-3373',result_y
  print,'-13670',result_z
  print,'29682',result_f

  ; finalize
  spawn,'mv iug_igrf11.db.tmp iug_igrf11.db'

end
