; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_MAP_DIAGNOSTICS_1_00
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/23/2013
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_map_diagnostics_1_00
;-

pro iug_load_ionospheric_cond_map_diagnostics_1_00
;
  yyyy = 2000
  mmdd = 101
  time = 0
  height_bottom = 100
  height_top = 100
  height_step = 0
  algorithm = 1
  resolution = 90

  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, resolution=resolution, result=result
;
  yyyy = 2000
  mmdd = 101
  time = 12
  height_bottom = 100
  height_top = 100
  height_step = 0
  algorithm = 1
  resolution = 90

  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, resolution=resolution, result=result
;
  yyyy = 1992
  mmdd = 101
  time = 0
  height_bottom = 100
  height_top = 100
  height_step = 0
  algorithm = 1
  resolution = 90

  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, resolution=resolution, result=result
;
  yyyy = 1992
  mmdd = 101
  time = 12
  height_bottom = 100
  height_top = 100
  height_step = 0
  algorithm = 1
  resolution = 90

  iug_load_ionospheric_cond_map, yyyy=yyyy, mmdd=mmdd, ltut=ltut, time=time, $
                                 height_bottom=height_bottom, height_top=height_top, height_step=height_step, $
                                 algorithm=algorithm, resolution=resolution, result=result

end
