!        Generated by TAPENADE     (INRIA, Tropics team)
!  Tapenade 3.10 (r5363) -  9 Sep 2014 09:53
!
!  Differentiation of getcostfunction in reverse (adjoint) mode (with options i4 dr8 r8 noISIZE):
!   gradient     of useful results: moment force
!   with respect to varying inputs: moment force
SUBROUTINE GETCOSTFUNCTION_B(costfunction, force, forceb, moment, &
     & momentb, sepsensor, cavitation, alpha, beta, liftindex, objvalue)
  ! Compute the value of the actual objective function based on the
  ! (summed) forces and moments and any other "extra" design
  ! variables. The index of the objective is determined by 'iDV'. This
  ! function is intended to be AD'ed in reverse mode. 
  USE INPUTTIMESPECTRAL
  USE COSTFUNCTIONS
  USE INPUTPHYSICS
  USE FLOWVARREFSTATE
  IMPLICIT NONE
  ! Input 
  INTEGER(kind=inttype), INTENT(IN) :: costfunction
  INTEGER(kind=inttype), INTENT(IN) :: liftindex
  REAL(kind=realtype), DIMENSION(3, ntimeintervalsspectral), INTENT(IN) &
       & :: force, moment
  REAL(kind=realtype), DIMENSION(3, ntimeintervalsspectral) :: forceb, &
       & momentb
  REAL(kind=realtype), DIMENSION(ntimeintervalsspectral), INTENT(IN) :: &
       & sepsensor, cavitation
  REAL(kind=realtype), INTENT(IN) :: alpha, beta
  ! Output
  REAL(kind=realtype) :: objvalue
  ! Working
  REAL(kind=realtype) :: fact, factmoment, scaledim, ovrnts
  REAL(kind=realtype), DIMENSION(3) :: cf, cm
  REAL(kind=realtype) :: elasticmomentx, elasticmomenty, elasticmomentz
  REAL(kind=realtype), DIMENSION(ntimeintervalsspectral, 8) :: basecoef
  REAL(kind=realtype), DIMENSION(8) :: coef0, dcdalpha, dcdalphadot, &
       & dcdq, dcdqdot
  REAL(kind=realtype) :: bendingmoment
  INTEGER(kind=inttype) :: sps
  EXTERNAL COMPUTETSDERIVATIVES
  EXTERNAL COMPUTETSDERIVATIVES_B
  EXTERNAL COMPUTEROOTBENDINGMOMENT
  INTEGER :: costfunccl0
  INTEGER :: costfuncliftcoef
  INTEGER :: costfuncforceycoef
  INTEGER :: costfuncclalphadot
  INTEGER :: costfuncmomycoef
  INTEGER :: costfunccmzalpha
  INTEGER :: costfunclift
  INTEGER :: costfuncsepsensor
  INTEGER :: costfuncforcez
  INTEGER :: costfuncforcey
  INTEGER :: costfuncforcexcoef
  INTEGER :: costfuncforcex
  INTEGER :: costfuncclq
  INTEGER :: costfunccmzqdot
  INTEGER :: costfuncmomxcoef
  INTEGER :: costfunccdqdot
  INTEGER :: costfuncbendingcoef
  INTEGER :: costfuncmomz
  INTEGER :: costfuncmomy
  INTEGER :: costfunccd0
  INTEGER :: costfuncmomx
  INTEGER :: costfunccm0
  INTEGER :: costfuncclalpha
  INTEGER :: costfuncclqdot
  INTEGER :: costfuncdrag
  INTEGER :: costfunccdalpha
  INTEGER :: costfunccdq
  INTEGER :: costfunccmzq
  INTEGER :: costfuncforcezcoef
  INTEGER :: costfunccavitation
  INTEGER :: costfuncdragcoef
  INTEGER :: costfunccdalphadot
  INTEGER :: costfunccmzalphadot
  INTEGER :: costfuncmomzcoef
  ! Compute the factor since we may need it below
  ! Pre-compute TS stability info if required:
  SELECT CASE  (costfunction) 
  CASE (costfunccl0, costfunccd0, costfunccm0, costfuncclalpha, &
       & costfunccdalpha, costfunccmzalpha, costfuncclalphadot, &
       & costfunccdalphadot, costfunccmzalphadot, costfuncclq, costfunccdq, &
       & costfunccmzq, costfuncclqdot, costfunccdqdot, costfunccmzqdot) 
     CALL COMPUTETSDERIVATIVES_B(force, forceb, moment, momentb, &
          &                         liftindex, coef0, dcdalpha, dcdalphadot, dcdq&
          &                         , dcdqdot)
  END SELECT
END SUBROUTINE GETCOSTFUNCTION_B