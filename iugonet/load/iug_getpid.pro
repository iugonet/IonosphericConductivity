; docformat = 'IDL'

;+
;
;Name:
;IUG_GETPID
;
;Purpose:
;To get PID
;
;Keywords:
;
;Code:
;Yukinobu KOYAMA, 10/20/2013
;
;Acknowledgment:
;
;EXAMPLE:
;  print,iug_getpid()
;-
function iug_getpid
  
  pid = call_external(!dlm_path+'/libidl.so','getpid',/cdecl)

  return,pid
end
