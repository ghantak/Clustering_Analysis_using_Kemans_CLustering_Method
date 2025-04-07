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
integer,dimension(mxbmol) :: atmpr,nsteps,nframes1,nframes2
character(len=100),dimension(mxb) :: ifile
character(len=100) :: ofile,rfile,bfile
character(len=8),dimension(mxbmol) :: ch5
character(len=1) :: ch6
logical :: there
data iunit,ounit,runit,bunit /11,12,13,14/

write(*,*)'Give the name of output file for final frame and cv print'
read(*,'(a)')ofile
open(ounit,file=ofile,status='unknown')

write(*,*)'Give the name of input file of frame cv1 and cv2 containing file'
read(*,'(a)')rfile
open(runit,file=rfile,status='old')

write(*,*)'Give the name of input file of kemans output of frame number'
read(*,'(a)')bfile
open(bunit,file=bfile,status='old')

!-------------------------------------------------------------------
!                        Extract bias Potential
!-------------------------------------------------------------------

nfb = 0
do
read(bunit, *, iostat=i)
if (i /= 0) exit
nfb = nfb + 1
enddo
rewind(bunit)

nfr = 0
do
read(runit, *, iostat=i)
if (i /= 0) exit
nfr = nfr + 1
enddo
rewind(runit)


write(*,*)'nsteps in the kemans file ======>',nfb
write(*,*)'nsteps in the cv file ======>',nfr


do i=1,nfr
read(runit,*)nframes1(i),a(i),b(i),nsteps(i)
enddo

do i=1,nfb
read(bunit,*)nframes2(i),ch5(i)
enddo

write(ounit,'(a13,5x,a3,14x,a3,7x,a10,4x,a7)')'# Frames','CV1','CV2','Percentage','# Steps'

mm=0
do i=1,nfb
   do j=1,nfr
if (nframes2(i)==nframes1(j))then
write(ounit,*)nframes1(j),a(j),b(j),ch5(i),nsteps(j)
cycle 
endif
enddo
enddo

END PROGRAM DCCM

