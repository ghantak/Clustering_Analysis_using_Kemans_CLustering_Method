! program to estimate the bias potential in each frame
!                                                    Date: 23 Sep, 2024

PROGRAM DCCM

integer,parameter :: mxb=220,mxbmol=500000,mxtm=3500000,mxtp=6,mxm=1500
integer, parameter :: dp = selected_real_kind(15, 307)
real(dp) :: kB, T, beta
real(kind=8) :: bx,bx1,by,by1,bz1,bz
real(kind=8) :: avrmsd,dt,r,rmsd,time
real,dimension(mxtm) :: x,y,z,bias,w
real,dimension(mxbmol) :: xr,yr,zr,mass,a,b
real(kind=8),dimension(mxm) :: r1,r2,r3,vx,vy,vz
real(kind=8),dimension(mxm,mxm) :: cri,crij,crj,tm
integer :: dt0,dummyi,ounit,runit,serial,bunit
integer,dimension(mxm) :: atm
integer,dimension(mxtp) :: iatom,imol,isit
integer,dimension(mxbmol) :: atmpr,nsteps
character(len=100),dimension(mxb) :: ifile
character(len=100) :: ofile,rfile,bfile
character(len=4) :: ch,ch2,ch5,snm
character(len=1) :: ch6
logical :: there
data iunit,ounit,runit,bunit /11,12,13,14/

write(*,*)'Give the name of output file for bias potential print'
read(*,'(a)')ofile
open(ounit,file=ofile,status='unknown')

write(*,*)'Give the name of input bias file'
read(*,'(a)')bfile
open(bunit,file=bfile,status='old')

write(*,*)'Give the skip value to match the dcd saving frequency'
read(*,*)nskip
write(*,*)'nskip =====>',nskip

!-------------------------------------------------------------------
!                        Extract bias Potential
!-------------------------------------------------------------------

nfr = 0
do
read(bunit, *, iostat=i)
if (i /= 0) exit
nfr = nfr + 1
enddo
rewind(bunit)

write(*,*)'nsteps in the bias file ======>',nfr

do i=1,nfr
read(bunit,*)nsteps(i),a(i),b(i),c,d,bias(i)
enddo

mm=0
do i=1,nfr
if (i==1)write(ounit,*)i,a(i),b(i),nsteps(i)
if(mod(nsteps(i),nskip) /= 0)cycle  
mm=mm+1
write(ounit,*)mm+1,a(i),b(i),nsteps(i)
enddo

END PROGRAM DCCM

