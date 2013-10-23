; docformat = 'IDL'

;+
;
;Name:
;IUG_ABB2COORDINATE
;
;Purpose:
;   Translate from ABB code to latitude & longitude
;
;Keywords:
;hoge
;
;Code:
;Yukinobu KOYAMA, 10/24/2011
;
;Modifications:
;Yukinobu KOYAMA, 04,19,2012
;
;Acknowledgment:
;
;EXAMPLE:
;result = iug_abb2coordinate('kak')
;print,result
;print,result.name
;print,result.glat
;print,result.glon
;
;-
function iug_abb2coordinate, abb

  abb = strupcase(abb)

  obj = obj_new('IDLjavaObject$IugWdcObservatory', 'IugWdcObservatory')
  result = obj->getGeographicCoordinate(abb)
  return,result

end
