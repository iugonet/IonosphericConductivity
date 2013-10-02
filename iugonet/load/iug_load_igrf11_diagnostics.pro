pro iug_load_igrf11_diagnostics
  ; initialize
  spawn,'mv iug_igrf11.db iug_igrf11.db.tmp' ; escape for testing
  spawn,'sqlite3 iug_igrf11.db < iug_igrf11.sql'

  ; main
  height_bottom=80
  height_top=120
  height_step=10
  yyyy=2000
  glat=0
  glon=0
  iug_load_igrf11_db,height_bottom=height_bottom,height_top=height_top,height_step=height_step,yyyy=yyyy,glat=glat,glon=glon

  ; finalize
  spawn,'mv iug_igrf11.db.tmp iug_igrf11.db'

end
