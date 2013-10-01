spawn,'sqlite3 -separator " " iug_igrf11.db < /tmp/test.sql > /tmp/tmp.txt'
  result=file_info('/tmp/tmp.txt')

  openr, unit, '/tmp/tmp.txt', /GET_LUN
  array=fltarr(21)
  readf,unit,array
  print,array
  close, unit
  
