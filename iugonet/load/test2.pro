pro test2

  set_plot, 'ps'
  device, filename='hoge.ps', /color, /encapsulated

  result_plot = fltarr(5,3) 
  result_plot(0,0) = 1.66675e-05
  result_plot(1,0) = 1.68677e-05
  result_plot(2,0) = 1.67391e-05
  result_plot(3,0) = 1.66662e-05
  result_plot(4,0) = 1.66675e-05

  result_plot(0,1) = 2.22609e-05
  result_plot(1,1) = 9.38571e-05
  result_plot(2,1) = 7.24560e-05
  result_plot(3,1) = 7.78099e-06
  result_plot(4,1) = 2.22609e-05

  result_plot(0,2) = 4.59411e-06
  result_plot(1,2) = 4.54708e-06
  result_plot(2,2) = 4.56344e-06
  result_plot(3,2) = 4.59411e-06
  result_plot(4,2) = 4.59411e-06

  glon_array = fltarr(5)
  glon_array(0) = -180.
  glon_array(1) = -90.
  glon_array(2) = 0.
  glon_array(3) = 90.
  glon_array(4) = 180.

  glat_array = fltarr(3)
  glat_array(0) = -89.
  glat_array(1) = 0.
  glat_array(2) = 89.
  
  map_set, /isotropic, title = str_title, limit=[-89, -180, 89, 180]
;/cylindrical, 0, 0, 

  nlevels = 24
  loadct,33
;, ncolors=nlevels, bottom=1
  contour, result_plot, glon_array, glat_array, /overplot, /cell,nlevels=nlevels, c_colors=IndGen(nlevels)
;, /closed
  fill_transparency = 30

  map_grid, latdel=10, londel=10, color=240
  map_continents
  
  print, result_plot
  print, glon_array
  print, glat_array

  device, /close
  set_plot, 'x'

end
