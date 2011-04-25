   !        Generated by TAPENADE     (INRIA, Tropics team)
   !  Tapenade 3.4 (r3375) - 10 Feb 2010 15:08
   !
   !  Differentiation of residual_block in forward (tangent) mode:
   !   variations   of useful results: *dw
   !   with respect to varying inputs: *p *w
   !
   !      ******************************************************************
   !      *                                                                *
   !      * File:          residual.f90                                    *
   !      * Author:        Edwin van der Weide, Steve Repsher (blanking)   *
   !      * Starting date: 03-15-2003                                      *
   !      * Last modified: 10-29-2007                                      *
   !      *                                                                *
   !      ******************************************************************
   !
   SUBROUTINE RESIDUAL_BLOCK_D()
   USE FLOWVARREFSTATE
   USE CGNSGRID
   USE INPUTITERATION
   USE BLOCKPOINTERS_D
   USE INPUTTIMESPECTRAL
   USE INPUTDISCRETIZATION
   USE ITERATION
   IMPLICIT NONE
   !
   !      ******************************************************************
   !      *                                                                *
   !      * residual computes the residual of the mean flow equations on   *
   !      * the current MG level.                                          *
   !      *                                                                *
   !      ******************************************************************
   !
   !
   !      Local variables.
   !
   INTEGER(kind=inttype) :: sps, nn, discr
   INTEGER(kind=inttype) :: i, j, k, l
   LOGICAL :: finegrid
   REAL :: result1
   INTRINSIC REAL
   !
   !      ******************************************************************
   !      *                                                                *
   !      * Begin execution                                                *
   !      *                                                                *
   !      ******************************************************************
   !
   ! Add the source terms from the level 0 cooling model.
   !call level0CoolingModel
   ! Set the value of rFil, which controls the fraction of the old
   ! dissipation residual to be used. This is only for the runge-kutta
   ! schemes; for other smoothers rFil is simply set to 1.0.
   ! Note the index rkStage+1 for cdisRK. The reason is that the
   ! residual computation is performed before rkStage is incremented.
   IF (smoother .EQ. rungekutta) THEN
   rfil = cdisrk(rkstage+1)
   ELSE
   rfil = one
   END IF
   ! Initialize the local arrays to monitor the massflows to zero.
   massflowfamilyinv = zero
   massflowfamilydiss = zero
   ! Set the value of the discretization, depending on the grid level,
   ! and the logical fineGrid, which indicates whether or not this
   ! is the finest grid level of the current mg cycle.
   discr = spacediscrcoarse
   IF (currentlevel .EQ. 1) discr = spacediscr
   finegrid = .false.
   IF (currentlevel .EQ. groundlevel) finegrid = .true.
   CALL INVISCIDCENTRALFLUX_MOD_D()
   ! Compute the artificial dissipation fluxes.
   ! This depends on the parameter discr.
   !   select case (discr)
   !   case (dissScalar) ! Standard scalar dissipation scheme.
   !      if( fineGrid ) then
   !         call inviscidDissFluxScalar
   !      else
   !         call inviscidDissFluxScalarCoarse
   !      endif
   !      !===========================================================
   !   case (dissMatrix) ! Matrix dissipation scheme.
   !      if( fineGrid ) then
   !         call inviscidDissFluxMatrix
   !      else
   !         call inviscidDissFluxMatrixCoarse
   !      endif
   !      !===========================================================
   !   case (dissCusp) ! Cusp dissipation scheme.
   !      if( fineGrid ) then
   !         call inviscidDissFluxCusp
   !      else
   !         call inviscidDissFluxCuspCoarse
   !      endif
   !      !===========================================================
   !   case (upwind) ! Dissipation via an upwind scheme.
   !      call inviscidUpwindFlux(fineGrid)
   !   end select
   !   ! Compute the viscous flux in case of a viscous computation.
   !   if( viscous ) call viscousFlux
   ! add the dissipative and possibly viscous fluxes to the
   ! Euler fluxes. Loop over the owned cells and add fw to dw.
   ! Also multiply by iblank so that no updates occur in holes
   ! or on the overset boundary.
   DO l=1,nwf
   DO k=2,kl
   DO j=2,jl
   DO i=2,il
   result1 = REAL(iblank(i, j, k), realtype)
   dwd(i, j, k, l) = result1*dwd(i, j, k, l)
   dw(i, j, k, l) = (dw(i, j, k, l)+fw(i, j, k, l))*result1
   END DO
   END DO
   END DO
   END DO
   END SUBROUTINE RESIDUAL_BLOCK_D
