; docformat = 'IDL'

;+
;NAME:
;
;EXAMPLE:
;-
function iug_debye_length,num_e,te

  return,6.9*(te/num_e)^(1./2.)

end
