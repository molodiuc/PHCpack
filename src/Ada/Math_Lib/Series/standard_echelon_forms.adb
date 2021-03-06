with text_io;                           use text_io;
with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Integer_Vectors_io;       use Standard_Integer_Vectors_io;
with Standard_Complex_Numbers;          use Standard_Complex_Numbers;

package body Standard_Echelon_Forms is

  function Is_Integer ( c : Complex_Number ) return boolean is

  -- DESCRIPTION :
  --   Returns true if the number c is an integer,
  --   returns false otherwise.

    rmf : constant double_float := REAL_PART(c);
    imf : constant double_float := IMAG_PART(c);
    tol : constant double_float := 1.0E-12;
    rmi : constant integer32 := integer32(rmf);
    imi : constant integer32 := integer32(imf);
 
  begin
    if abs(double_float(rmi) - rmf) > tol then
      return false;
    elsif abs(double_float(imi) - imf) > tol then
      return false;
    else
      return true;
    end if;
  end Is_Integer;

  procedure Write_Integer_Matrix
              ( A : in Standard_Complex_Matrices.Matrix ) is
  begin
    for i in A'range(1) loop
      for j in A'range(2) loop
        if Is_Integer(A(i,j)) then
          put(" "); put(integer32(REAL_PART(A(i,j))),2);
        else
          put("  *");
        end if;
      end loop;
      new_line;
    end loop;
  end Write_Integer_Matrix;

  function Is_Zero_Row 
              ( A : Standard_Complex_Matrices.Matrix;
                i : integer32; tol : double_float ) return boolean is
  begin
    for j in A'range(2) loop
      if AbsVal(A(i,j)) > tol
       then return false;
      end if;
    end loop;
    return true;
  end Is_Zero_Row;

  procedure Swap_Rows
              ( A : in out Standard_Complex_Matrices.Matrix;
                i,j : in integer32 ) is

    tmp : Complex_Number;   

  begin
    for k in A'range(2) loop
      tmp := A(i,k);
      A(i,k) := A(j,k);
      A(j,k) := tmp;
    end loop;
  end Swap_Rows;

  procedure Swap_Elements
              ( v : in out Standard_Integer_Vectors.Vector;
                i,j : in integer32 ) is

    tmp : constant integer32 := v(i);

  begin
    v(i) := v(j);
    v(j) := tmp;
  end Swap_Elements;

  procedure Swap_Zero_Rows
              ( A : in out Standard_Complex_Matrices.Matrix;
                ipvt : out Standard_Integer_Vectors.Vector;
                tol : in double_float; pivrow : out integer32 ) is

    idx : integer32 := A'first(1); -- first nonzero row

  begin
    for i in A'range(1) loop
      if Is_Zero_Row(A,i,tol) then
        if i /= idx then
          Swap_Rows(A,i,idx);
          Swap_Elements(ipvt,i,idx);
        end if;
        idx := idx + 1;
      end if;
    end loop;
    pivrow := idx;
  end Swap_Zero_Rows;

  function Max_on_Row
             ( A : Standard_Complex_Matrices.Matrix;
               i,j : integer32; tol : double_float ) return integer32 is

    res : integer32 := j;
    maxval : double_float := AbsVal(A(i,j));
    val : double_float;

  begin
    for k in j+1..A'last(2) loop
      val := AbsVal(A(i,k));
      if val > maxval
       then maxval := val; res := k;
      end if;
    end loop;
    if maxval > tol
     then return res;
     else return -1;
    end if;
  end Max_on_Row;

  procedure Swap_Columns
              ( A : in out Standard_Complex_Matrices.Matrix;
                ipvt : in out Standard_Integer_Vectors.Vector;
                j,k : in integer32 ) is

    Atmp : Complex_Number;

  begin
    for i in A'range(1) loop
      Atmp := A(i,j);
      A(i,j) := A(i,k);
      A(i,k) := Atmp;
    end loop;
    Swap_Elements(ipvt,j,k);
  end Swap_Columns;

  procedure Eliminate_on_Row
              ( A : in out Standard_Complex_Matrices.Matrix;
                U : out Standard_Complex_Matrices.Matrix;
                i,j : in integer32; tol : in double_float ) is

     fac : Complex_Number;
     first : boolean := true;

  begin
    for k in j+1..A'last(2) loop
      if AbsVal(A(i,k)) > tol then
        if first then
          for kk in A'range(2) loop  -- wipe i-th multiplier row clean
            U(i,kk) := Create(0.0);
          end loop;
          first := false;
        end if;
        fac := A(i,k)/A(i,j);
        U(i,j) := Create(1.0); -- mark the pivot column
        U(i,k) := -fac;        -- store the multiplier
        U(k,k) := Create(1.0); -- triangular submatrix
        for row in i..A'last(1) loop
          A(row,k) := A(row,k) - fac*A(row,j);
        end loop;
      end if;
    end loop;
  end Eliminate_on_Row;

  procedure Lower_Triangular_Echelon_Form
              ( A : in out Standard_Complex_Matrices.Matrix;
                U : out Standard_Complex_Matrices.Matrix;
                row_ipvt : out Standard_Integer_Vectors.Vector;
                col_ipvt,pivots : out Standard_Integer_Vectors.Vector;
                verbose : in boolean := true ) is

    tol : constant double_float := 1.0E-12;
    pivrow,pivcol,colidx : integer32;

  begin
    for k in row_ipvt'range loop
      row_ipvt(k) := k;
    end loop;
    for k in col_ipvt'range loop
      col_ipvt(k) := k;
      pivots(k) := k;
    end loop;
    for i in U'range(1) loop
      for j in U'range(2) loop
        U(i,j) := Create(0.0);
      end loop;
      U(i,i) := Create(1.0);
    end loop;
    Swap_Zero_Rows(A,row_ipvt,tol,pivrow);
    if verbose then
      put_line("After swapping zero rows :"); Write_Integer_Matrix(A);
    end if;
    colidx := A'first(2);
    loop
      pivcol := Max_on_Row(A,pivrow,colidx,tol);
      if verbose then
        put("The pivot row : "); put(pivrow,1); 
        put("  pivot column : "); put(pivcol,1); 
        put("  column index : "); put(colidx,1); new_line;
      end if;
      if pivcol /= -1 then -- if no pivot, then skip row
        pivots(colidx) := pivcol;
        if pivcol /= colidx then
          Swap_Columns(A,col_ipvt,colidx,pivcol);
          if verbose then
            put_line("After swapping columns : "); Write_Integer_Matrix(A);
            put("The pivoting information : "); put(col_ipvt); new_line;
          end if;
        end if;
        Eliminate_on_Row(A,U,pivrow,colidx,tol);
        if verbose then
          put_line("After elimination on the pivot row :");
          Write_Integer_Matrix(A);
        end if;
        colidx := colidx + 1;
      end if;
      pivrow := pivrow + 1;
      exit when ((pivrow > A'last(1)) or (colidx > A'last(2)));
    end loop;
  end Lower_Triangular_Echelon_Form;

  function Row_Permutation_Matrix
             ( ipvt : Standard_Integer_Vectors.Vector )
             return Standard_Integer_Matrices.Matrix is

    res : Standard_Integer_Matrices.Matrix(ipvt'range,ipvt'range);

  begin
    for i in res'range(1) loop
      for j in res'range(2) loop
        res(i,j) := 0;
      end loop;
    end loop;
    for i in ipvt'range loop
      res(i,ipvt(i)) := 1;
    end loop;
    return res;
  end Row_Permutation_Matrix;

  function Column_Permutation_Matrix
             ( ipvt : Standard_Integer_Vectors.Vector )
             return Standard_Integer_Matrices.Matrix is

    res : Standard_Integer_Matrices.Matrix(ipvt'range,ipvt'range);

  begin
    for i in res'range(1) loop
      for j in res'range(2) loop
        res(i,j) := 0;
      end loop;
    end loop;
    for i in ipvt'range loop
      res(ipvt(i),i) := 1;
    end loop;
    return res;
  end Column_Permutation_Matrix;

  procedure Solve_with_Echelon_Form
              ( L : in Standard_Complex_Matrices.Matrix;
                b : in Standard_Complex_Vectors.Vector;
                x : out Standard_Complex_Vectors.Vector ) is

    row : integer32 := L'first(1);
    col : integer32 := L'first(2);
    val : double_float;

  begin
    x := (x'range => Create(0.0));
    loop
      val := AbsVal(L(row,col));
      if val + 1.0 /= 1.0 then -- else skip row
        x(col) := b(row);
        for j in L'first(2)..(col-1) loop
          x(col) := x(col) - L(row,j)*x(j);
        end loop;
        x(col) := x(col)/L(row,col);
        col := col + 1;
      end if;
      row := row + 1;
      exit when ((row > L'last(1)) or (col > L'last(2)));
    end loop;
  end Solve_with_Echelon_Form;

  procedure Multiply_and_Permute
              ( x : in out Standard_Complex_Vectors.Vector;
                U : in Standard_Complex_Matrices.Matrix;
                pivots : in Standard_Integer_Vectors.Vector ) is

    acc : Complex_Number;
   -- M : Standard_Complex_Matrices.Matrix(U'range(1),U'range(2));
    one : constant Complex_Number := Create(1.0);
    pivcol : integer32;
   -- val : double_float;

   -- use Standard_Complex_Matrices;

  begin
    for k in reverse U'range(2) loop
     -- for i in M'range(1) loop
     --   for j in M'range(2) loop
     --     M(i,j) := Create(0.0);
     --   end loop;
     --   M(i,i) := Create(1.0);
     -- end loop;
      pivcol := k;
      for j in U'range(2) loop
        if Equal(U(k,j),one) then
          pivcol := j;
          exit;
       -- else
       --   val := AbsVal(U(k,j));
       --   if val + 1.0 /= 1.0 then
       --     M(pivcol,j) := U(k,j);
       --   end if;
        end if;
      end loop;
     -- x := M*x; -- only x(pivcol) changes
      acc := Create(0.0);
      for j in U'range(2) loop
        acc := acc + U(pivcol,j)*x(j);
      end loop;
      x(pivcol) := acc;
      if pivots(k) /= k then
        acc := x(k);
        x(k) := x(pivots(k));
        x(pivots(k)) := acc;
      end if;
    end loop;
   -- for i in reverse U'range(1) loop
   --   acc := Create(0.0);
   --   for j in U'range(2) loop
   --     acc := acc + U(i,j)*x(j);
   --   end loop;
   --   x(i) := acc;
   --   if pivots(i) /= i then
   --     acc := x(i);
   --     x(i) := x(pivots(i));
   --     x(pivots(i)) := acc;
   --   end if;
   -- end loop;
  end Multiply_and_Permute;

end Standard_Echelon_Forms;
