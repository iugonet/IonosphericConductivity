; docformat = 'IDL'

;+
;
;Name:
;IUG_LOAD_IONOSPHERIC_COND_DIAGNOSTICS_1_09
;
;Purpose:
;
;Syntax:
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 08/23/2012
;
;Modifications:
;
;Acknowledgment:
;
;Example:
; IDL> thm_init
; THEMIS> iug_load_ionospheric_cond_diagnostics_1_09
;-

pro iug_load_ionospheric_cond_diagnostics_1_09

  height_bottom=100
  height_top=400
  height_step=10
  glat=44.6 ; this parameter is from figure 9.2.3 of Richmond's textbook
  glon=2.2  ; this parameter is from figure 9.2.3 of Richmond's textbook
  ltut=0
  yyyy=1987 ; Make a choice the year which is small solar activity.
  time=12
  algorithm=1 ;
  mmdd=321  ; this parameter is from figure 9.2.3 of Richmond's textbook

  num_height = (height_top-height_bottom)/height_step+1
  height_array=fltarr(num_height)

  for i=0L,num_height-1 do begin
     height_array(i)=height_bottom+height_step*i
  endfor

; definition of physical constants 
  e_charge = 1.60217733E-19          ; (C)                                    
  m_e = 9.1093817E-31                ; (kg)                                  
  m_p = 1.6726231E-27                ; (kg)  

; Calculation of IRI2012 model
  iug_load_iri2012,yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time,glat=glat,glon=glon,height_bottom=height_bottom,height_top=height_top,height_step=height_step,result=result_iri

;
; Calculation of NRLMSISE for getting composition of atmosphere
;
  iug_load_nrlmsise00, yyyy=yyyy, mmdd=mmdd, height_bottom=height_bottom,height_top=height_top, height_step=height_step,time=time,glat=glat,glon=glon,result=result_msis

;
; IGRF11
; 
  iug_load_igrf11, height_bottom=height_bottom, height_top=height_top, height_step=height_step, yyyy=yyyy, glat=glat, glon=glon, r_d=r_d, r_i=r_i, r_h=r_h,r_x=r_x,r_y=r_y,r_z=r_z,r_f=r_f

;
; Calculation based on Kenichi Maeda's equation
;
  result = fltarr(6,num_height)
  nu_in_reso = fltarr(num_height)
  nu_in_exchange = fltarr(num_height)

  for i=0L,num_height-1 do begin
     if algorithm eq 1 then begin
; t_e,n2,o2,o,h,he                                                              
        nu_en=iug_collision_freq1_en(result_iri[5,i],result_msis[4,i],$
                                     result_msis[5,i],result_msis[3,i],$
                                     result_msis[7,i],result_msis[2,i])
        nu_ei=iug_collision_freq1_ei(result_iri[1,i],result_iri[5,i])
        nu_e=nu_en+nu_ei
        nu_i=iug_collision_freq1_in(result_msis[2,i],result_msis[3,i],$
                                   result_msis[4,i],result_msis[5,i],$
                                   result_msis[6,i],result_msis[7,i],$
                                   result_msis[8,i],result_msis[9,i],$
                                   result_iri[6,i],result_iri[7,i],$
                                   result_iri[8,i],result_iri[9,i],$
                                   result_iri[10,i],result_iri[11,i])
        iug_collision_freq1_in_reso,tn=result_iri[3,i],ti=result_iri[4,i],$
                                    nh1=result_msis[7,i],$
                                    no1=result_msis[3,i],$
                                    nn1=result_msis[8,i],$
                                    nhe=result_msis[2,i],$
                                    no2=result_msis[5,i],$
                                    nn2=result_msis[4,i],$
                                    fh1_reso=fh1_reso,fo1_reso=fo1_reso,$
                                    fn1_reso=fn1_reso,fhe_reso=fhe_reso,$
                                    fo2_reso=fo2_reso,fn2_reso=fn2_reso
        nu_in_reso[i] = fh1_reso+fo1_reso+fn1_reso+fhe_reso+fo2_reso+fn2_reso
        iug_collision_freq1_in_exchange,tn=result_iri[3,i],ti=result_iri[4,i],$
                                        nh1=result_msis[7,i],$
                                        no1=result_msis[3,i],$
                                        nn1=result_msis[8,8],$
                                        nhe=result_msis[2,i],$
                                        no2=result_msis[5,i],$
                                        nn2=result_msis[4,8],$
                                        fh1_exchange=fh1_exchange,$
                                        fo1_exchange=fo1_exchange,$
                                        fn1_exchange=fn1_exchange,$
                                        fhe_exchange=fhe_exchange,$
                                        fo2_exchange=fo2_exchange,$
                                        fn2_exchange=fn2_exchange
        nu_in_exchange[i] = fh1_exchange+fo1_exchange+fn1_exchange $
                         +fhe_exchange+fo2_exchange+fn2_exchange
     endif
     if algorithm eq 2 then begin
        r_e=result_iri[5,i]/300.
        nu_en_para=iug_collision_freq2_en_para(r_e,result_msis[4,i]*1E6,result_msis[5,i]*1E6,result_msis[3,i]*1E6)
        nu_ei_para=iug_collision_freq2_ei_para(result_iri[1,i]*1E6,result_iri[5,i])
        nu_e_para=nu_en_para+nu_ei_para
        nu_e=nu_e_para
        nu_en_perp=iug_collision_freq2_en_perp(r_e,result_msis[4,i]*1E6,result_msis[5,i]*1E6,result_msis[3,i]*1E6)

        r_i=(result_iri[3,i]+result_iri[4,i])/1000.
        nu_i=iug_collision_freq2_in(r_i,result_msis[4,i]*1E6,result_msis[5,i]*1E6,result_msis[3,i]*1E6,result_iri[11,i]*1E6,result_iri[10,i]*1E6,result_iri[6,i]*1E6)
     endif

;     m_i= ( (16*m_p*result_iri[6,i]/100-m_e)*result_iri[2,i] $
;           + (14*m_p*result_iri[7,i]/100-m_e)*result_iri[2,i] $
;           + (1.*m_p*result_iri[8,i]/100.-m_e)*result_iri[2,i] $
;           + (4.*m_p*result_iri[9,i]/100.-m_e)*result_iri[2,i] $
;           + (32.*m_p*result_iri[10,i]/100.-m_e)*result_iri[2,i] $
;           + (30.*m_p*result_iri[11,i]/100.-m_e)*result_iri[2,i] ) $
;          /result_iri[2,i]
     num_o_p = result_iri[1,i]*1.E6*result_iri[6,i] /100. ; O+            
     num_n_p = result_iri[1,i]*1.E6*result_iri[7,i] /100. ; N+            
     num_h_p = result_iri[1,i]*1.E6*result_iri[8,i] /100. ; H+            
     num_he_p= result_iri[1,i]*1.E6*result_iri[9,i] /100. ; He+           
     num_o2_p= result_iri[1,i]*1.E6*result_iri[10,i]/100. ; O2+           
     num_no_p= result_iri[1,i]*1.E6*result_iri[11,i]/100. ; NO+           
     num_cluster_p = result_iri[1,i]*1.E6*result_iri[12,i]/100. ; Cluster+
     num_ions= result_iri[1,i]*1.E6                             ; Ne/m-3    

     m_i = ( 16.* num_o_p $
           + 14.* num_n_p $
           + 1. * num_h_p $
           + 4. * num_he_p $
           + 32.* num_o2_p $
           + 30.* num_no_p $
           + 82.* num_cluster_p) / num_ions * m_p

     omega_e = ( e_charge*r_f[i]*1.E-9 )/(m_e)
     omega_i = ( e_charge*r_f[i]*1.E-9 )/(m_i)
     kappa = ( omega_e*omega_i )/( nu_e*nu_i )

     result[0,i]=height_array[i]
     result[1,i]=omega_i
     result[2,i]=omega_e
     result[3,i]=nu_i
     result[4,i]=nu_en
     result[5,i]=nu_en+nu_ei
  endfor

  set_plot,'ps'
  device,filename='/tmp/iug_load_ionospheric_cond_diagnostics_1_09.ps',/color

  plot,result[1,*],result[0,*],xtitle="Collision Frequencies and Gyrofrequencies (Hz)",ytitle="Altitude (km)",yrange=[0,400],xrange=[1E-2,1E8],/xlog,linestyle=0,color=0, title="GLAT=44.6, GLON=2.2, Solar-minimum conditions (Sa=75) on March 21"
  oplot, result[2,*],result[0,*],linestyle=0,color=6
  oplot, result[3,*],result[0,*],linestyle=0,color=2    ; nu_in
  oplot, nu_in_reso,result[0,*],linestyle=1,color=4     ; nu_in_reso
  oplot, nu_in_exchange,result[0,*],linestyle=2,color=7 ; nu_in_exchange
  oplot, result[4,*],result[0,*],linestyle=0,color=1
  oplot, result[5,*],result[0,*],linestyle=0,color=3
  xyouts,5.E2,370,"omega_i",color=0
  xyouts,2.E5,370,"omega_e",color=6
  xyouts,2.E-1,270,"nu_in",color=2
  xyouts,1.E0,260,"nu_in_reso",color=2
  xyouts,2.E-1,120,"nu_in_exchange",color=2
  xyouts,2.E1,210,"nu_en",color=1
  xyouts,5.E2,220,"nu_en+nu_ei",color=3

  device,/close
  set_plot,'x'

end
