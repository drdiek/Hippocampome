/* libraries to be included */

#include <stdio.h>   // standard input-output
#include <math.h>    // math library
#include <string.h>  // string stuff
#include <malloc.h>  // allocation stuff
#include <sunperf.h> // Sun performance library (including BLAS and LAPACK)
#include <mex.h>     // mex (Matlab external) stuff 

/* Handy to define these macros for later.  Note that C arrays always begin from position 0 */
#define A_IN prhs[0]   /* first (and only) input parameter (right-hand side) */
#define Q_OUT plhs[0]  /* first output parameter (left-hand side)  */
#define R_OUT plhs[1]  /* second output parameter */

/* These routines call BLAS (Basic Linear Algebra Subroutines) implemented in the        
 * Sun Performance Library. This is DIFFERENT from calling routines from Netlib's CLAPACK.
 * When calling routines from CLAPACK, have to append trailing underscore after the name.
 * This is NOT necessary when calling LAPACK routines from the Sun performance library  
 * Also, when calling routines from CLAPACK, even scalars that don't return a value have 
 * to be passed by reference.  This is NOT done when calling LAPACK routines from the Sun
 * Performance Library . The reason is that CLAPACK conventions follow Fortran, where   
 * everything is call by reference (no call by value.)  For more info, see p. 36 of
 * Sun Performance Library User's Guide. */

/* To access the Sun Performance Library, it's necessary to use the "cc" compiler on 
 * Solaris (NOT gcc) */

/* the following would declare BLAS as external functions 
 * However, it's not necessary to declare these...they are declared in sunperf.h,
 * which is included above, so this is commented out.
 * Arrays are called by reference, but scalars are called by value 
 * this applies to int, real and double scalars */

/*   dcopy copies a vector to another vector (the last two ints are increments, usually 1)
 * extern void dcopy(int, double *, int, double *, int);  
 *   daxpy adds a scalar times a vector to a second vector (first double is a scalar) 
 * extern void daxpy(int, double, double *, int, double *, int);    
 *   dnrm2 returns the 2-norm of a vector 
 * extern double dnrm2(int, double *, int); 
 *   dscal multiplies a scalar onto a vector 
 * extern void dscal(int, double, double *, int);  
 *   ddot returns the dot product of two vectors 
 * extern double ddot(int, double *, int, double *, int);  */

/*-------------------------------------------------------------------*/

/* Note the double asterisk for two-dimensional arrays in C */

/* Here is the routine that implements Classical Gram Schmidt in C.
 * This routine is given the name clgs so that it can be called from another C program
 * as an alternative to calling it from inside MATLAB via mexFunction.  However, it could
 * have any name, as long as it is the one being called by mexFunction.  It is the FILE name
 * that matters when you type "mex clgs.c" inside MATLAB */

void clgs(int m, int n, double **A, double **Q, double **R)
{ 
/* classical Gram-Schmidt (unstable) to compute 
 *  "reduced" QR factorization of A
 *  input: A (m by n, with m >= n)
 *  output: Q (orthogonal columns, m by n)
 *          R (upper triangular, n by n)
 *  properties: A = Q*R (in exact arithmetic)
 *  reference: Trefethen and Bau, Alg 7.1    
 */

/* declare variables */
   int i, j;
   double *v, scalfac;

/* check dimensions are valid */
   if (m < n) {
      fprintf(stderr, "invalid dimension for A\n");
      exit(-1);
   }

/* allocate space for local array v */

   if ((v = (double *) calloc(m,sizeof(double))) == (double *)NULL) {
      fprintf(stderr, "out of memory"); 
      exit(-1);
   }

/* Each two-dimensional array is implemented as a pointer to an
 * array of pointers, of which the j-th points to the first data entry 
 * in the j-th column.  Thus A[j] points to the first data entry in the
 * j-th column and A[j][i] is the i-th data entry in the j-th column.
 * Thus it is assumed that the data are stored consecutively
 * within each column.  If clgs is called as a mex function from Matlab,
 * this is done automatically.  If it's called from a stand-alone C
 * function, remember this when allocating the data.
 */

/* compute QR via Gram-Schmidt */
   for (j = 0; j < n; j++) {
      /* at jth step through loop, we take jth column of A and
       * add multiples of previous columns of Q to it to construct
       * jth column of Q with property that 
       *   - the j columns of Q and A span same space
       *   - the j columns of Q are mutually orthonormal
       */

      /* copy jth column of A to v */
      dcopy(m, A[j], 1, v, 1);  /* call to BLAS */
      for (i = 0; i < j; i++) {   /* does nothing if i=j */
         /* Matlab: R(i,j) = Q(:,i)'*A(:,j) */
         R[j][i] = ddot(m, Q[i], 1, A[j], 1);  /* call to BLAS */
         /* Matlab: v = v - R(i,j)*Q(:,i)  constructed so v is orthogonal
          *                                to all columns of Q generated so far */
         scalfac = -R[j][i];
         daxpy(m, scalfac, Q[i], 1, v, 1);  /* BLAS: add scalfac times Q[i] vector to v */
      }  /* i loop */
      /* Matlab: R(j,j) = norm(v) (could use + or -) */
      R[j][j] = dnrm2(m, v, 1);  
      /* Matlab: Q(:,j) = v */
      dcopy(m, v, 1, Q[j], 1);  /* call to BLAS */
      /* Matlab: Q(:j) = Q(:,j)/R(j,j) */
      scalfac = 1.0/R[j][j];
      dscal(m, scalfac, Q[j], 1);  /* call to BLAS */
   }   /* j loop */
   free(v);       /* free up space used by v */
}   /* end of function clgs */
   
/*-------------------------------------------------------------------*/
/* MEX interface function, also written in C, which calls the function clgs.
 * Parameters are number of output args, array of output args, number of
 * input args, and array of input args (const makes these unchangeable) */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{ 
   int i, m, n; 
   double **A, **Q, **R;   // pointers to pointers to double, i.e. 2-D arrays

   /* check number of parameters */
   if (nrhs != 1) {
      mexErrMsgTxt("clgs.c requires one input argument.");
   } else if (nlhs != 2) {
      mexErrMsgTxt("clgs.c requires two output arguments.");
   }

   /* convert Matlab arrays into format suitable for the C function clgs.
    * Note: the macros A_IN, Q_OUT and R_OUT are defined at the top of the
    * file to be the input and output parameters. */

   m = mxGetM(A_IN);    /* row size of input parameter */
   n = mxGetN(A_IN);    /* column size of input parameter */

   /* allocate space for pointers into columns of A, Q and R */
   if ((A = (double **) calloc(n,sizeof(double*))) == (double **)NULL) {
      fprintf(stderr, "out of memory");
      exit(-1);
   }
   if ((Q = (double **) calloc(n,sizeof(double*))) == (double **)NULL) {
      fprintf(stderr, "out of memory");
      exit(-1);
   }
   if ((R = (double **) calloc(n,sizeof(double*))) == (double **)NULL) {
      fprintf(stderr, "out of memory");
      exit(-1);
   }

   /* allocate space for output parameters in special MATLAB MEX format */
   Q_OUT = mxCreateDoubleMatrix(m,n,mxREAL);  
   R_OUT = mxCreateDoubleMatrix(n,n,mxREAL);
   /* set up the C pointers to point to the right places */
   for (i = 0; i < n; i++) {
      A[i] = mxGetPr(A_IN) + i*m;    // since A is m by n
      Q[i] = mxGetPr(Q_OUT) + i*m;   // since Q is m by n
      R[i] = mxGetPr(R_OUT) + i*n;   // since R is n by n
   }

   printf("calling the C function clgs\n");   // prints to the Matlab session window
   fprintf(stdout, "calling the C function clgs\n");  // for some reason this doesn't have same effect on my Sun!
   clgs(m, n, A, Q, R); /* actual computation */

} /* end function mexFunction */

/*-------------------------------------------------------------------*/
