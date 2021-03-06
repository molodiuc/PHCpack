with Standard_Integer_Numbers;            use Standard_Integer_Numbers;
with Quad_Double_Numbers;                 use Quad_Double_Numbers;
with Standard_Integer_Vectors;
with QuadDobl_Complex_Vectors;
with QuadDobl_Complex_Matrices;
with QuadDobl_Dense_Vector_Series;
with QuadDobl_Dense_Matrix_Series;

package QuadDobl_Matrix_Series_Solvers is

-- DESCRIPTION :
--   Given a linear system of truncated power series, linearization with
--   matrix series and vector series solves the linear system.
--   The coefficients and computations are in quad double precision.

  procedure Solve_Lead_by_lufac
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                a0lu : out QuadDobl_Complex_Matrices.Matrix;
                ipvt : out Standard_Integer_Vectors.Vector;
                info : out integer32;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies LU factorization and back substitution to compute the
  --   constant coefficient of the solution series to A*x = b.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.  Moreover, the system is square.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   a0lu     LU factorization of A.cff(0);
  --   ipvt     pivoting information on the LU factorization of A.cff(0);
  --   info     returned by lufac, if nonzero, then the lead coefficient
  --            matrix was deemed singular by lufac;
  --   x        x.cff(0) is the constant coefficient of the solution
  --            and x.deg = 0, provided info = 0,
  --            if info /= 0, then x.deg = -1 and x.cff(0) is undefined.

  procedure Solve_Lead_by_lufco
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                a0lu : out QuadDobl_Complex_Matrices.Matrix;
                ipvt : out Standard_Integer_Vectors.Vector;
                rcond : out quad_double;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies LU factorization and back substitution to compute the
  --   constant coefficient of the solution series to A*x = b.
  --   An estimate for the inverse of the condition number is returned.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.  Moreover, the system is square.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   a0lu     LU factorization of A.cff(0);
  --   ipvt     pivoting information on the LU factorization of A.cff(0);
  --   rcond    computed by lufco, if 1.0 + rcond = 1.0, then the lead
  --            coefficient matrix should be considered as singular;
  --   x        x.cff(0) is the constant coefficient of the solution
  --            and x.deg = 0, provided 1.0 + rcond /= 1.0,
  --            if 1.0 + rcond = 1.0, then x.deg = -1
  --            and x.cff(0) is undefined.

  procedure Solve_Lead_by_QRLS
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                a0qr : out QuadDobl_Complex_Matrices.Matrix;
                qraux : out QuadDobl_Complex_Vectors.Vector;
                ipvt : out Standard_Integer_Vectors.Vector;
                info : out integer32;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies QR decomposition and least squares solving to compute the
  --   constant coefficient of the solution series A*x = b.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   a0qr     the QR decomposition of the leading coefficient of A;
  --   qraux    information to recover the orthogonal part;
  --   ipvt     pivoting information if that was requested;
  --   info     is zero of nonsingular, otherwise, a nonzero info
  --            indicates a singular matrix.

  procedure Solve_Lead_by_SVD
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                S : out QuadDobl_Complex_Vectors.Vector;
                U,V : out QuadDobl_Complex_Matrices.Matrix;
                info : out integer32; rcond : out quad_double;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies Singular Value Decomposition (SVD) to compute the
  --   constant coefficient of the solution series A*x = b.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   S        vector of range 1..mm, where mm = min(n+1,p),
  --            where n = A.cff(0)'last(1) and p = A.cff(0)'last(2),
  --            the first min(n,p) entries of s contain the singular values
  --            of x arranged in descending order of magnitude;
  --   U        matrix with n rows and k columns, 
  --            if joba = 1, then k = n, if joba >= 2 then k = min(n,p),
  --            u contains the matrix of left singular vectors,
  --            u is not referenced if joba = 0, if n <= p or if joba > 2,
  --            then u may be identified with x in the subroutine call;
  --   V        matrix with p rows and p columns,
  --            v contains the matrix of right singular vectors,
  --            v is not referenced if jobb = 0, if p <= n, then v may be
  --            identified with x in the subroutine call;
  --   info     the singular values (and their corresponding singular vectors)
  --            s(info+1),s(info+2),...,s(m) are correct (here m=min(n,p)),
  --            thus if info = 0, all the singular values and their vectors
  --            are correct, in any event, the matrix b = ctrans(u)*x*v is
  --            the bidiagonal matrix with the elements of s on its diagonal
  --            and the elements of e on its super diagonal (ctrans(u) is the
  --            conjugate-transpose of u), thus the singular values of x 
  --            and b are the same;
  --   rcond    is the outcome of Inverse_Condition_Number(S),
  --            the inverse condition number based on the singular values;
  --   x        x.cff(0) is the constant coefficient of the solution
  --            and x.deg = 0, provided info = 0,
  --            if info /= 0, then x.deg = -1 and x.cff(0) is undefined.

  procedure Solve_Next_by_lusolve
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                a0lu : in QuadDobl_Complex_Matrices.Matrix;
                ipvt : in Standard_Integer_Vectors.Vector;
                x : in out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies LU back substitution, calling lusolve,
  --   on the linear system with a modified right hand side vector,
  --   using previously computed coefficient series vector of x.

  -- REQUIRED :
  --   All coefficients up to x.deg are defined and the system is square.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series;
  --   a0lu     output of Solve_Lead_by_lufac, contains the LU
  --            factorization of the leading coefficient of A;
  --   ipvt     output of Solve_Lead_by_lufac, contains the pivoting
  --            information in the LU factorization of A.cff(0);
  --   x        previously computed coefficients of the solution,
  --            at the very least, x.cff(0) must be defined.

  -- ON RETURN :
  --   x        computed coefficients up to b.deg.

  procedure Solve_Next_by_QRLS
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                a0qr : in QuadDobl_Complex_Matrices.Matrix;
                qraux : in QuadDobl_Complex_Vectors.Vector;
                info : out integer32;
                x : in out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies QR decomposition and least squares solving to compute the
  --   next coefficient of the solution series A*x = b.

  -- REQUIRED :
  --   All coefficients up to x.deg are defined.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.
  --   a0qr     the QR decomposition of the leading coefficient of A,
  --            as output of Solve_Lead_by_QRLS;
  --   qraux    information to recover the orthogonal part,
  --            as output of Solve_Lead_by_QRLS;
  --   x        previously computed coefficients of the solution,
  --            at the very least, x.cff(0) must be defined.

  -- ON RETURN :
  --   info     is zero of nonsingular, otherwise, a nonzero info
  --            indicates a singular matrix;
  --   x        computed coefficient at x.deg+1 with respect to input.

  procedure Solve_Next_by_SVD
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                S : in QuadDobl_Complex_Vectors.Vector;
                U,V : in QuadDobl_Complex_Matrices.Matrix;
                x : in out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Applies the SVD decomposition of the lead coefficient of A
  --   to compute the next coefficient of the solution series A*x = b.

  -- REQUIRED :
  --   All coefficients up to x.deg are defined.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series;
  --   S        singular values of the lead coefficient of A,
  --            computed by Solve_Lead_by_SVD;
  --   U,V      computed by Solve_Lead_by_SVD;
  --   x        previously computed coefficients of the solution,
  --            at the very least, x.cff(0) must be defined.

  -- ON RETURN :
  --   x        computed coefficient at x.deg+1 with respect to input.

  procedure Solve_by_lufac
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                info : out integer32;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Solves the linear system A*x = b, using LU factorization on the
  --   leading coefficient matrix of A, without condition number estimate.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.  Moreover, the system is square.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   info     if info /= 0, then the lead coefficient matrix of A
  --            was deemed singular and x is undefined,
  --            if info = 0, then the system is regular;
  --   x        all coefficients of the solution series up to b.deg,
  --            provided info = 0.

  procedure Solve_by_lufco
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                rcond : out quad_double;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Solves the linear system A*x = b, using LU factorization on the
  --   leading coefficient matrix of A, with condition number estimate.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.  Moreover, the system is square.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   rcond    estimate for the inverse condition number,
  --            if 1.0 + rcond = 1.0, then the lead coefficient matrix of A
  --            was deemed singular and x is undefined,
  --            if 1.0 + rcond /= 1.0, then the system is regular;
  --   x        all coefficients of the solution series up to b.deg,
  --            provided 1.0 + rcond /= 1.0.

  procedure Solve_by_QRLS
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                info : out integer32;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Solves the linear system A*x = b, using QR decomposition of the
  --   leading coefficient matrix of A and least squares solving.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   info     if info /= 0, then the lead coefficient matrix of A
  --            was deemed singular and x is undefined,
  --            if info = 0, then the system is regular;
  --   x        all coefficients of the solution series up to b.deg,
  --            provided info = 0.

  procedure Solve_by_SVD
              ( A : in QuadDobl_Dense_Matrix_Series.Matrix;
                b : in QuadDobl_Dense_Vector_Series.Vector;
                info : out integer32; rcond : out quad_double;
                x : out QuadDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Solves the linear system A*x = b, using the SVD of the
  --   leading coefficient matrix of A for least squares solving.

  -- REQUIRED :
  --   A.deg >= 0 and b.deg >= 0.

  -- ON ENTRY :
  --   A        the coefficient matrix as a matrix series;
  --   b        the right hand side as a vector series.

  -- ON RETURN :
  --   info     see the output of Solve_Lead_by_SVD;
  --   rcond    inverse condition number computed from the singular
  --            values of the lead coefficient of A;
  --   x        all coefficients of the solution series up to b.deg,
  --            provided rcond /= 0.0.

end QuadDobl_Matrix_Series_Solvers;
