!        Generated by TAPENADE     (INRIA, Tropics team)
!  Tapenade 2.2.4 (r2308) - 03/04/2008 10:03
!  
!
!      ******************************************************************
!      *                                                                *
!      * File:          blockPointers.f90                               *
!      * Author:        Edwin van der Weide, Steve Repsher              *
!      * Starting date: 03-07-2003                                      *
!      * Last modified: 11-21-2007                                      *
!      *                                                                *
!      ******************************************************************
!
MODULE BLOCKPOINTERS_D
  USE block_d
  IMPLICIT NONE
!
!      ******************************************************************
!      *                                                                *
!      * This module contains the pointers for all variables inside a   *
!      * block. The pointers are set via the subroutine setPointers,    *
!      * which can be found in the utils directory. In this way the     *
!      * code becomes much more readable. The relation to the original  *
!      * multiblock grid is not copied, because it does not affect the  *
!      * computation.                                                   *
!      *                                                                *
!      * See the module block for the meaning of the variables.         *
!      *                                                                *
!      * Note that the dimensions are not pointers, but integers.       *
!      * Consequently changing dimensions of a block must be done only  *
!      * with the variables of floDoms.                                 *
!      *                                                                *
!      ******************************************************************
!
!
!      ******************************************************************
!      *                                                                *
!      * Additional info, such that it is known to which block the data *
!      * inside this module belongs.                                    *
!      *                                                                *
!      ******************************************************************
!
! sectionID:   the section to which this block belongs.
! nbkLocal :   local block number.
! nbkGlobal:   global block number in the original cgns grid.
! mgLevel:     the multigrid level.
! spectralSol: the spectral solution index of this block.
  INTEGER(KIND=INTTYPE) :: sectionid
  INTEGER(KIND=INTTYPE) :: nbklocal, nbkglobal, mglevel
  INTEGER(KIND=INTTYPE) :: spectralsol
!
!      ******************************************************************
!      *                                                                *
!      * Variables, which are either copied or the pointer is set to    *
!      * the correct variable in the block. See the module block for    *
!      * meaning of the variables.                                      *
!      *                                                                *
!      ******************************************************************
!
  INTEGER(KIND=INTTYPE) :: nx, ny, nz, il, jl, kl
  INTEGER(KIND=INTTYPE) :: ie, je, ke, ib, jb, kb
  INTEGER(KIND=INTTYPE) :: ibegor, iendor, jbegor, jendor
  INTEGER(KIND=INTTYPE) :: kbegor, kendor
  INTEGER(KIND=INTTYPE) :: nsubface, n1to1, nbocos, nviscbocos
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: bctype
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: bcfaceid
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: cgnssubface
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: inbeg, inend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: jnbeg, jnend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: knbeg, knend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: dinbeg, dinend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: djnbeg, djnend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: dknbeg, dknend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: icbeg, icend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: jcbeg, jcend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: kcbeg, kcend
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: neighblock
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: neighproc
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: l1, l2, l3
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: groupnum
  INTEGER(KIND=INTTYPE) :: ncellsoverset, ncellsoversetall
  INTEGER(KIND=INTTYPE) :: nholes, norphans
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: iblank
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: ibndry
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: idonor
  REAL(KIND=REALTYPE), DIMENSION(:, :), POINTER :: overint
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: neighblockover
  INTEGER(KIND=INTTYPE), DIMENSION(:), POINTER :: neighprocover
  TYPE(BCDATATYPE), DIMENSION(:), POINTER :: bcdata
  TYPE(VISCSUBFACETYPE), DIMENSION(:), POINTER :: viscsubface
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: visciminpointer
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: viscimaxpointer
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: viscjminpointer
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: viscjmaxpointer
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: visckminpointer
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: visckmaxpointer
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: x
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: xold
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: si, sj, sk
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: vol
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: volold
  INTEGER(KIND=PORTYPE), DIMENSION(:, :, :), POINTER :: pori
  INTEGER(KIND=PORTYPE), DIMENSION(:, :, :), POINTER :: porj
  INTEGER(KIND=PORTYPE), DIMENSION(:, :, :), POINTER :: pork
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: indfamilyi
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: indfamilyj
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: indfamilyk
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: factfamilyi
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: factfamilyj
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: factfamilyk
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: rotmatrixi
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: rotmatrixj
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: rotmatrixk
  LOGICAL :: blockismoving, addgridvelocities
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: sfacei
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: sfacej
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: sfacek
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: w
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: wold
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: p, gamma
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: rlv, rev
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: s
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: p1
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: dw, fw
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :, :), POINTER :: dwoldrk
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: w1, wr
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgifine
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgjfine
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgkfine
  REAL(KIND=REALTYPE), DIMENSION(:), POINTER :: mgiweight
  REAL(KIND=REALTYPE), DIMENSION(:), POINTER :: mgjweight
  REAL(KIND=REALTYPE), DIMENSION(:), POINTER :: mgkweight
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgicoarse
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgjcoarse
  INTEGER(KIND=INTTYPE), DIMENSION(:, :), POINTER :: mgkcoarse
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: wn
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: pn
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: dtl
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: radi
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: radj
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: radk
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: d2wall
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmti1
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmti2
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmtj1
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmtj2
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmtk1
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: bmtk2
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: bvti1, bvti2
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: bvtj1, bvtj2
  REAL(KIND=REALTYPE), DIMENSION(:, :, :), POINTER :: bvtk1, bvtk2
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: globalnode
  INTEGER(KIND=INTTYPE), DIMENSION(:, :, :), POINTER :: globalcell
  REAL(KIND=REALTYPE), DIMENSION(:, :, :, :), POINTER :: psiadj
END MODULE BLOCKPOINTERS_D
