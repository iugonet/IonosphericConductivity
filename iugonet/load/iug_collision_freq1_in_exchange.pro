; docformat = 'IDL'
 
;+
;
;Name:
;IUG_COLLISION_FREQ1_IN
;
;Purpose:
;To calulate ionic collision frequency
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 05/07/2012
;
;Modifications:
;
;Acknowledgment:
;
;EXAMPLE:
;  
;-

pro iug_collision_freq1_in_exchange,tn=tn,ti=ti,$
                                    nh1=nh1,no1=no1,nn1=nn1,$
                                    nhe=nhe,no2=no2,nn2=nn2,$
                                    fh1_exchange=fh1_exchange,$
                                    fo1_exchange=fo1_exchange,$
                                    fn1_exchange=fn1_exchange,$
                                    fhe_exchange=fhe_exchange,$
                                    fo2_exchange=fo2_exchange,$
                                    fn2_exchange=fn2_exchange

  iug_collision_freq1_in_reso,tn=tn,ti=ti,$
                              nh1=nh1,no1=no1,nn1=nn1,$
                              nhe=nhe,no2=no2,nn2=nn2,$
                              fh1_reso=fh1_reso,fo1_reso=fo1_reso,$
                              fn1_reso=fn1_reso,fhe_reso=fhe_reso,$
                              fo2_reso=fo2_reso,fn2_reso=fn2_reso
; charge exchange collision frequency
  fh1_exchange = fh1_reso / 2.
  fo1_exchange = fo1_reso / 2.
  fn1_exchange = fn1_reso / 2.
  fhe_exchange = fhe_reso / 2.
  fo2_exchange = fo2_reso / 2.
  fn2_exchange = fn2_reso / 2.

end
