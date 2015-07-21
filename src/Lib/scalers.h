/* The file scalers.h contains prototypes to scale systems and solutions.
 * By default, compilation with gcc is assumed.
 * To compile with a C++ compiler such as g++, the flag compilewgpp must
 * be defined as "g++ -Dcompilewgpp=1." */

#ifndef __SCALERS_H__
#define __SCALERS_H__

#ifdef compilewgpp
extern "C" void adainit( void );
extern "C" int _ada_use_c2phc ( int task, int *a, int *b, double *c );
extern "C" void adafinal( void );
#else
extern void adainit( void );
extern int _ada_use_c2phc ( int task, int *a, int *b, double *c );
extern void adafinal( void );
#endif

int standard_scale_system ( int mode, double *cff );
/*
 * DESCRIPTION :
 *   Applies scaling to the system in the standard systems container,
 *   with standard double precision arithmetic.
 *   The system in the standard systems container is replaced by
 *   the scaled system.
 *
 * REQUIRED :
 *   An equal number of equations as variables is assumed.
 *
 * ON ENTRY :
 *   mode    0 for only scaling of the equations,
 *           1 variable scaling without variability reduction,
 *           2 variable scaling with variability reduction;
 *   cff     allocated space for 4*dim + 2 doubles, if mode > 0.
 *
 * ON RETURN :
 *   cff     contains the scaling coefficients and condition number
 *           of the scaling problem, if the mode on input was > 0.
 *           The last double in cff is the estimated inverse condition
 *           number (as a complex number) in the solved linear system. */

int dobldobl_scale_system ( int mode, double *cff );
/*
 * DESCRIPTION :
 *   Applies scaling to the system in the dobldobl systems container,
 *   with double double precision arithmetic.
 *   The system in the dobldobl systems container is replaced by
 *   the scaled system.
 *
 * REQUIRED :
 *   An equal number of equations as variables is assumed.
 *
 * ON ENTRY :
 *   mode    0 for only scaling of the equations,
 *           1 variable scaling without variability reduction,
 *           2 variable scaling with variability reduction;
 *   cff     allocated space for 8*dim + 4 doubles, if mode > 0.
 *
 * ON RETURN :
 *   cff     contains the scaling coefficients and condition number
 *           of the scaling problem, if the mode on input was > 0.
 *           The last 4 doubles in cff is the estimated inverse condition
 *           number (as a complex number) in the solved linear system. */

int quaddobl_scale_system ( int mode, double *cff );
/*
 * DESCRIPTION :
 *   Applies scaling to the system in the quaddobl systems container,
 *   with quad double precision arithmetic.
 *   The system in the quaddobl systems container is replaced by
 *   the scaled system.
 *
 * REQUIRED :
 *   An equal number of equations as variables is assumed.
 *
 * ON ENTRY :
 *   mode    0 for only scaling of the equations,
 *           1 variable scaling without variability reduction,
 *           2 variable scaling with variability reduction;
 *   cff     allocated space for 16*dim + 8 doubles, if mode > 0.
 *
 * ON RETURN :
 *   cff     contains the scaling coefficients and condition number
 *           of the scaling problem, if the mode on input was > 0.
 *           The last 8 doubles in cff store the estimated inverse condition
 *           number (as a complex number) in the solved linear system. */

#endif