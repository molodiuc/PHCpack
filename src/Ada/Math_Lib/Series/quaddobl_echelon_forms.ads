with Standard_Integer_Numbers;             use Standard_Integer_Numbers;
with Standard_Floating_Numbers;            use Standard_Floating_Numbers;
with Standard_Integer_Vectors;
with QuadDobl_Complex_Vectors;
with QuadDobl_Complex_Matrices;

package QuadDobl_Echelon_Forms is

-- DESCRIPTION :
--   Given a lower block triangular matrix, the operations in this package
--   transform the given matrix into a lower triangular echelon form.
--   Solving a linear system in lower triangular echelong form
--   can then be done by forward substitution.
--   Computations are done in quad double precision.

  procedure Write_Integer_Matrix
              ( A : in QuadDobl_Complex_Matrices.Matrix );

  -- DESCRIPTION :
  --   Writes values in A which are integers as integer numbers to screen.
  --   Values in A that are not integer numbers are written as *.

  function Is_Zero_Row 
              ( A : QuadDobl_Complex_Matrices.Matrix;
                i : integer32; tol : double_float ) return boolean;

  -- DESCRIPTION :
  --   Returns true if all elements on the i-th row of A
  --   are less than tol in magnitude.  Returns false otherwise.

  procedure Swap_Rows
              ( A : in out QuadDobl_Complex_Matrices.Matrix;
                i,j : in integer32 );

  -- DESCRIPTION :
  --   Swaps row i with row j in A.

  procedure Swap_Zero_Rows
              ( A : in out QuadDobl_Complex_Matrices.Matrix;
                ipvt : out Standard_Integer_Vectors.Vector;
                tol : in double_float; pivrow : out integer32 );

  -- DESCRIPTION :
  --   Moves zero rows in A to the top of the matrix,
  --   storing the pivoting information in the ipvt vector.

  -- REQUIRED : A'range(1) = b'range.

  -- ON ENTRY :
  --   A        block upper triangular coefficient matrix;
  --   tol      tolerance to decide whether a number is zero or not.

  -- ON RETURN :
  --   A        matrix with all zero rows on top;
  --   ipvt     stores the pivoting information;
  --   pivrow   index of the first nonzero row in A.

  function Max_on_Row
             ( A : QuadDobl_Complex_Matrices.Matrix;
               i,j : integer32; tol : double_float ) return integer32;

  -- DESCRIPTION :
  --   Returns the index k >= j on row i for which A(i,k) is largest.
  --   If all elements on the row, right of the pivot j, are less
  --   then tol, then -1 is returned.

  procedure Swap_Columns
              ( A : in out QuadDobl_Complex_Matrices.Matrix;
                ipvt : in out Standard_Integer_Vectors.Vector;
                j,k : in integer32 );

  -- DESCRIPTION :
  --   Swaps the columns j and k in A, and the corresponding pivoting
  --   information in ipvt as well.

  procedure Eliminate_on_Row
              ( A : in out QuadDobl_Complex_Matrices.Matrix;
                U : out QuadDobl_Complex_Matrices.Matrix;
                i,j : in integer32; tol : in double_float );

  -- DESCRIPTION :
  --   Eliminates all elements at the right of the pivot (i,j)
  --   in A by column operations.

  -- ON ENTRY :
  --   A        matrix with nonzero pivot at row i and column j;
  --   i        index of the pivot row;
  --   j        index of the pivot column;
  --   tol      tolerance to decide whether a number is zero or not.
  --
  -- ON RETURN :
  --   A        elements at the right of (i,j) are made zero;
  --   U        the multiplier for the pivot to eliminate the k-th
  --            element is stored at position (i,k).

  procedure Lower_Triangular_Echelon_Form
              ( A : in out QuadDobl_Complex_Matrices.Matrix;
                U : out QuadDobl_Complex_Matrices.Matrix;
                row_ipvt : out Standard_Integer_Vectors.Vector;
                col_ipvt,pivots : out Standard_Integer_Vectors.Vector;
                verbose : in boolean := true );

  -- DESCRIPTION :
  --   Given a block lower triangular matrix A, 
  --   the procedure computes a lower triangular echelon form of A.
  --   If verbose, then intermediate results are written to screen.

  -- ON ENTRY :
  --   A        block lower triangular matrix;
  --   verbose  flag to indicate if intermediate output is needed.

  -- ON RETURN :
  --   A        lower triangular echelon form;
  --   U        multiplier elements used in the column reductions
  --            at the right of the pivots;
  --   row_ipvt stores the pivoting information for the swapping of
  --            the zero rows to the top of the matrix A;
  --   col_ipvt stores the pivoting information for the swapping of
  --            the columns in the determination of the next pivot;
  --   pivots   sequence of column pivots in the order in which
  --            they were generated.

  procedure Solve_with_Echelon_Form
              ( L : in QuadDobl_Complex_Matrices.Matrix;
                b : in QuadDobl_Complex_Vectors.Vector;
                x : out QuadDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Does the forward substitution on the lower triangular echelon
  --   form in L with in b the right hand side vector,
  --   to solve L*x = b.  The solution is returned in x.
  --   If all diagonal elements on L are nonzero,
  --   then the residual || b-L*x || should be close to machine precision.

  procedure Multiply_and_Permute
              ( x : in out QuadDobl_Complex_Vectors.Vector;
                U : in QuadDobl_Complex_Matrices.Matrix;
                pivots : in Standard_Integer_Vectors.Vector );

  -- DESCRIPTION :
  --   Applies the transformations defined by the multipliers in U
  --   and permutations defined by the pivots to x.

  -- ON ENTRY :
  --   x        solution x of Solve_with_Echelon_Form(L,b);
  --   U        multiplier matrix computed by Lower_Triangular_Echelon_Form;
  --   pivots   pivots computed by Lower_Triangular_Echelon_Form.

  -- ON RETURN :
  --   x        transformed solution, to the origin problem A*x = b.

end QuadDobl_Echelon_Forms;
