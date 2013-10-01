program main
  implicit none

  integer :: i,j
  real,dimension(:,:),allocatable :: D
  real,dimension(:,:),allocatable :: T
  real,dimension(25) :: SW
  real,dimension(7) :: APH
  real :: UT,XLAT,XLONG,XLST,F107A,F107,AP
  integer :: IDAY
  real, dimension(16) :: DL
  integer,dimension(3) :: ISDATE
  integer,dimension(2) :: ISTIME
  character,dimension(2) :: NAME*4
!
  real :: ALT_BOTTOM, ALT_TOP, ALT_STEP
  integer :: IALT_NUM
  real,dimension(:),allocatable :: ALT
!
  COMMON/GTS3C/DL
  COMMON/DATIME/ISDATE,ISTIME,NAME
!  DATA IDAY/172,81,13*172/
!  DATA UT/29000.,29000.,75000.,12*29000./
!  DATA XLAT/4*60.,0.,10*60./
!  DATA XLONG/5*-70.,0.,9*-70./
!  DATA XLST/6*16.,4.,8*16./
!  DATA F107A/7*150.,70.,7*150./
!  DATA F107/8*150.,180.,6*150./
!  DATA AP/9*4.,40.,5*4./
!  DATA APH/7*100./,SW/8*1.,-1.,16*1./

  D=0
  T=0

  read(*,*) ALT_BOTTOM
  read(*,*) ALT_TOP
  read(*,*) ALT_STEP
  IALT_NUM=(ALT_TOP-ALT_BOTTOM)/ALT_STEP+1

  ALLOCATE(ALT(IALT_NUM))
  ALT=0
  do I=1,IALT_NUM
     ALT(I)=ALT_BOTTOM+ALT_STEP*(I-1)
  end do
  ALLOCATE(D(9,IALT_NUM))
  D=0
  ALLOCATE(T(2,IALT_NUM))
  T=0
  read(*,*) IDAY
  read(*,*) XLST
  read(*,*) UT
  read(*,*) XLAT
  read(*,*) XLONG
  read(*,*) F107A
  read(*,*) F107
  read(*,*) AP

  do I=1,IALT_NUM
     CALL GTD7(IDAY,UT,ALT(I),XLAT,XLONG,XLST,F107A,F107,AP,48,D(1,I),T(1,I))
  end do

!  WRITE(*,100) (D(J,I),J=1,9),T(1,I),T(2,I),DL
!  WRITE(*,300) NAME,ISDATE,ISTIME
!  WRITE(*,200) IDAY
!  WRITE(*,201) UT
!  WRITE(*,202) (ALT(I),I=1,15)
!  WRITE(*,203) XLAT
!  WRITE(*,204) XLONG
!  WRITE(*,205) XLST
!  WRITE(*,206) F107A
!  WRITE(*,207) F107
!  WRITE(*,208) AP
  do I=1, IALT_NUM
     write(*,'(e12.3,e12.3,e12.3,e12.3,e12.3,e12.3,e12.3,e12.3,e12.3,e12.3,e12.3)') T(1,I),T(2,I),D(1,I),D(2,I),D(3,I),D(4,I),D(5,I),D(7,I),D(8,I),D(9,I),D(6,I)
  end do
  STOP

end program main
