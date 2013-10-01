;+
;
;- 
thm_init

station=iug_abb2coordinate('kak')
iug_load_ionospheric_cond, height_bottom=80, height_top=120,height_step=5, 
glat=35, glon=135, yyyy=2000,mmdd=130,ltut=0,time=12, result=result

print,result

plot,result[0,*],result[1,*],xtitle="height;(km)",ytitle="conductivity sigma_0;(S/m)"                                      
plot,result[0,*],result[2,*],xtitle="height;(km)",ytitle="conductivity sigma_1(S/m)"                                      
plot,result[0,*],result[3,*],xtitle="height;(km)",ytitle="conductivity sigma_2 (S/m)" 
