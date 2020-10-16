!usage: RATTLEPOS.x infile x y z (index cutoff) scale low hi
! x is the number of elts and y is the number of rattled structures needed, z is the intensity of the rattle
! no constraints for now
! 7 lines only before coordinates pls
program rattlepos

implicit none

double precision::randx,randy,randz,rand_max,intensity, cutoff, scalelow, scalehi, scaleval
double precision,allocatable,dimension(:,:)::R
double precision,allocatable,dimension(:)::distvec
CHARACTER*100 :: d1, d2, d3, d4, d5, d6, infile
CHARACTER*250 ::  outfile
CHARACTER*32  :: argument, formatt
integer::step, i,j, struct, arg, natom, ind
integer,allocatable, dimension(:)::num

CALL init_random_seed()
CALL getarg(1, argument)
!Read in the input POSCAR
read(argument,*) infile
CALL getarg(2, argument)
!Read in the number of elts
read(argument,*) arg
allocate(num(arg))
CALL getarg(3, argument)
!Read in the number of rattled geometries needed 
read(argument,*) struct
CALL getarg(4, argument)
!Read in the intensity of rattle 
read(argument,*) intensity
CALL getarg(5, argument)
!Read in either the index of central atom for locality test (1-N) or set scaling of the box (-1) 
read(argument,*) ind

!If locality test read in the locality sphere cutoff - atoms within this sphere will not be rattled
if(ind > 0) then
CALL getarg(6, argument)
read(argument,*) cutoff
endif

!If scaling is desired then give a up and low range for the scale factor
if(ind < 0) then
CALL getarg(6, argument)
read(argument,*) scalelow
CALL getarg(7, argument)
read(argument,*) scalehi
endif

natom=0

open(10,file=infile,status="old")
read(10,'(A120)')d1
read(10,'(A120)')d2
read(10,'(A120)')d3
read(10,'(A120)')d4
read(10,'(A120)')d5
read(10,*) num(:)
do i = 1,arg
  natom=natom+num(i)
 enddo
allocate(R(natom,3))
read(10,*)d6
do i = 1,natom
  read(10,*) R(i,:)
enddo
close(10)

if(ind>0) then
allocate(distvec(natom))
do i=1,natom
  distvec(i)=sqrt( (R(ind,1)-R(i,1))*(R(ind,1)-R(i,1)) + (R(ind,2)-R(i,2))*(R(ind,2)-R(i,2)) + (R(ind,3)-R(i,3))*(R(ind,3)-R(i,3)) )
  !write(*,*)i,distvec(i)
enddo
endif

do j= 1, struct

if(ind == 0) then
write(formatt,*) "(A,A,I4.4,A,F4.2)"
write(outfile,formatt) TRIM(infile),"-", j,"-", intensity
else
write(formatt,*) "(A,A,I4.4,A,F4.2,A,I4.4,A,F4.2)"
write(outfile,formatt) TRIM(infile),"-", j,"-", intensity,"-",ind,"-",cutoff
endif


open(20,file=outfile,status="unknown")
  write(20,'(g0)')d1 
  if(ind < 0) then
   CALL RANDOM_NUMBER(randx)
   RAND_MAX=1.0
   scaleval=scalelow+((randx/RAND_MAX)*(scalehi-scalelow))
   write(20,'(g0)') scaleval
  else
   write(20,'(g0)')d2 
  endif
  write(20,'(g0)')d3 
  write(20,'(g0)')d4 
  write(20,'(g0)')d5 
write(20,*)num(:)
write(20,'(g0)')d6
 do i = 1,natom
  CALL RANDOM_NUMBER(randx)
  CALL RANDOM_NUMBER(randy)
  CALL RANDOM_NUMBER(randz)
  RAND_MAX=1.0
  if(ind >0) then
  if(distvec(i) > cutoff) then
  write(20,*)R(i,1) + intensity*((2.0 * (randx / RAND_MAX) ) - 1.0), &
R(i,2) + intensity*((2.0*(randy/RAND_MAX)) - 1.0), R(i,3)+intensity*((2.0*(randz/RAND_MAX)) - 1.0)
  else
  write(20,*)R(i,1) , R(i,2) , R(i,3)
  endif
  else
          write(20,*)R(i,1) + intensity*((2.0 * (randx / RAND_MAX) ) - 1.0), &
R(i,2) + intensity*((2.0*(randy/RAND_MAX)) - 1.0), R(i,3)+intensity*((2.0*(randz/RAND_MAX)) - 1.0)
  endif
 enddo
close(20)
enddo

if(ind>0) then
deallocate(R, num, distvec)
else
deallocate(R, num)
endif
end program rattlepos

!############################################################
!#subroutine for random number seed
!############################################################


SUBROUTINE init_random_seed()

INTEGER :: i, n, clock
INTEGER, DIMENSION(:), ALLOCATABLE :: seed

CALL RANDOM_SEED(size = n)
ALLOCATE(seed(n))

CALL SYSTEM_CLOCK(COUNT=clock)

seed = clock + 37 * (/ (i - 1, i = 1, n) /)
CALL RANDOM_SEED(PUT = seed)

DEALLOCATE(seed)

END SUBROUTINE

