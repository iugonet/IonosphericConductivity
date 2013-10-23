; docformat = 'IDL'

;+
;NAME: IUG_DEBYE_LENGTH
;
;INPUTS:
;
;PORPOSE:
;
;SYNTAX:
;
;Code: 
;Yukinobu KOYAMA, 4/25/2012
;
;Modifications:
;Yukinobu KOYAMA, 10/23/2013
;
;EXAMPLE:
;-

function iug_debye_length, num_e, te

  return,6.9*(te/num_e)^(1./2.)

end
