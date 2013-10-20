; docformat = 'rst'

;+
;
; :Keywords:
;     keyword1 : In, Type=float
;
; :Author:  Yukinobu KOYAMA
;
; :History:  Aug,19,2012
;-
thm_init

sites=['abn','abk','aae','agn','ale','abg','asp','aaa','alm','amt','aml','ann','api','arc','aia','ars','asc','ash','blc','bng','bgy','brw','bsl','bji','bmt','bel','bjn','box','bou','bfe','bdv','byr','cbb','cnb','ccs','cto','cwe','csy','clf','cta','clh','cdp','cbi','coi','cmo','czt','dal','dvs','dbn','dlr','dik','dob','dou','drv','ebr','elt','svd','esa','esk','eyr','fcc','frd','frn','fuq','fur','gln','gna','gdh','glm','grm','gwc','gck','gua','gzh','gui','hba','hbk','had','hty','his','hlp','her','hon','hrn','hua','hrb','hyb','iqa','irt','isk','jai','kdu','kak','kny','knz','kgd','kzn','kiv','kir','kod','kor','kou','aqu','lqa','lzh','szt','lrm','lrv','lnn','ler','liv','lgr','mmk','lmm','lov','lua','lnp','lvv','mbo','mcq','mgd','mab','mzl','mrn','ams','maw','mea','mmb','mnk','mir','miz','mfp','mol','mos','mbc','mut','ngp','nck','naq','vna','new','ngk','nvl','nvs','nur','ode','ott','pag','ppt','pab','pet','phu','pil','pod','pnd','paf','pmg','pst','pbq','qsb','qix','res','rsv','sab','sfs','sjg','spt','sna','sba','ssh','shl','sil','sso','sit','sod','sge','spa','stj','sua','tam','tan','tng','tkt','ttb','tfs','teh','teo','thl','thy','tir','tik','tol','thj','too','trw','trd','tro','tsu','tuc','ujj','ups','vlj','val','vss','vic','vqs','vsk','vla','vos','wat','wik','wil','wng','wit','whn','yak','ykc','yss']

nsites= n_elements(sites)

yyyy=2000
mmdd=130
time=12
height_bottom=100
height_top=600
height_step=1
ltut=0

openw, unit, '/tmp/result2d.txt',/get_lun
for i=0L, nsites-1 do begin
   site=iug_abb2coordinate(sites[i])
   iug_load_ionospheric_cond, height_bottom=height_bottom, height_top=height_top,height_step=height_step, glat=site.glat, glon=site.glon, yyyy=yyyy,mmdd=mmdd,ltut=ltut,time=time, result=result

;
   set_plot,'ps'
   if (ltut eq 0) then begin
      filename='/tmp/'+'cond_'+sites[i]+string(yyyy,format='(i4.4)')+'_'+string(mmdd,format='(i4.4)')+'_LT'+string(time,format='(i2.2)')+'.ps'
   endif
   if (ltut eq 1) then begin
      filename='/tmp/'+'cond_'+sites[i]+string(yyyy,format='(i4.4)')+'_'+string(mmdd,format='(i4.4)')+'_UT'+string(time,format='(i2.2)')+'.ps'
   endif
   print,"FILENAME=",filename
   device,filename=filename,/color
   plot,result[1,*],result[0,*],xtitle="Conductivity(S/m)",ytitle="Altitude (km)",xrange=[1E-8,1E2],yrange=[height_bottom,height_top],/xlog, linestyle=0, color=0                                      
   oplot,result[2,*],result[0,*],linestyle=0, color=6
   oplot,result[3,*],result[0,*],linestyle=0, color=2

   xyouts,1,height_bottom+(height_top-height_bottom)/20*3,"sigma0",color=0
   xyouts,1,height_bottom+(height_top-height_bottom)/20*2,"sigma1",color=6
   xyouts,1,height_bottom+(height_top-height_bottom)/20*1,"sigma2",color=2
   set_plot,'x'

; height integrated conductivity
   result2d = iug_height_integrated_cond(result)
   printf,unit,sites[i],site.glat,site.glon,result2d

endfor
free_lun,unit

end
