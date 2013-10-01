; docformat = 'IDL'
 
;+
;NAME:
;
;EXAMPLE:
;-
function iug_coulomb_logarithm,debye_length,velocity,mu

  e_charge=4.8032068E-10 ; (esu)
  return, alog( ( mu*(velocity^2.)*debye_length )/(e_charge^2.) )

end
