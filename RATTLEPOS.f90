!usage: RATTLEPOS.x infile x y z
! x is the number of elts and y is the number of rattled structures needed, z is the intensity of the rattle
! no constraints for now
! 7 lines only before coordinates pls
program rattlepos

implicit none

real::randx,randy,randz,rand_max,intensity
double precision,allocatable,dimension(:,:)::R
CHARACTER*100 :: d1, d2, d3, d4, d5, d6, infile, outfile
CHARACTER*32  :: argument
integer::step, i,j, struct, arg, natom
integer,allocatable, dimension(:)::num

CALL init_random_seed()
CALL getarg(1, argument)
read(argument,*) infile
CALL getarg(2, argument)
read(argument,*) arg
allocate(num(arg))
CALL getarg(3, argument)
read(argument,*) struct
CALL getarg(4, argument)
read(argument,*) intensity
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

do j= 1, struct
write(outfile,'(A,I4.4,F4.4)') "POSCAR",j,intensity
open(20,file=outfile,status="unknown")
  write(20,'(g0)')d1 
  write(20,'(g0)')d2 
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
  write(20,*)R(i,1) + intensity*((2.0 * (randx / RAND_MAX) ) - 1.0), &
R(i,2) + intensity*((2.0*(randy/RAND_MAX)) - 1.0), R(i,3)+intensity*((2.0*(randz/RAND_MAX)) - 1.0)
 enddo
close(20)
enddo

deallocate(R, num)
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

