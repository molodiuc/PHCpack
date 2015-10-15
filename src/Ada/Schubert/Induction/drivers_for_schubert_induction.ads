with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Multprec_Natural_Numbers;           use Multprec_Natural_Numbers;
with Standard_Natural_Vectors;
with Standard_Natural_VecVecs;
with Standard_Complex_VecMats;
with Standard_Complex_Poly_Systems;      use Standard_Complex_Poly_Systems;
with Standard_Complex_Solutions;         use Standard_Complex_Solutions;
with Brackets;                           use Brackets;
with Bracket_Monomials;                  use Bracket_Monomials;
with Intersection_Posets;                use Intersection_Posets;
with Intersection_Solution_Posets;       use Intersection_Solution_Posets;

package Drivers_for_Schubert_Induction is

-- DESCRIPTION :
--   Offers drivers to the Littlewood-Richardson homotopies.

  function Prompt_for_Bracket_Monomial return Bracket_Monomial;

  -- DESCRIPTION :
  --   Prompts the user for a product of brackets,
  --   i.e.: for a Schubert intersection problem.

  function Process_Conditions
             ( n,k,m : integer32; conds : Array_of_Brackets )
             return Intersection_Posets.Intersection_Poset;

  -- DESCRIPTION :
  --   Process the m conditions stored in conds on k-planes in n-space.
  --   Returns the intersection poset.

  function Bracket_to_Vector
             ( b : Bracket ) return Standard_Natural_Vectors.Vector;

  -- DESCRIPTION :
  --   Converts the bracket to a vector of standard natural numbers.

  function Remaining_Intersection_Conditions
             ( b : Array_of_Brackets )
             return Standard_Natural_VecVecs.VecVec;

  -- DESCRIPTION :
  --   Returns the remaining b'last-2 conditions stored in b.

  -- REQUIRED : b'last > 2.

  function Is_Isolated 
              ( b : Standard_Natural_Vectors.Vector ) return boolean;

  -- DESCRIPTION :
  --   A bracket represents an isolated solution if b(i) = i
  --   for all i in b'range.

  function Number_of_Isolated_Solutions
              ( ips : Intersection_Poset ) return Natural_Number;

  -- DECRIPTION :
  --   Returns the number of isolated solutions at the top level
  --   of an intersection poset of a resolved intersection condition.

  procedure Create_Intersection_Poset
              ( n,nb : in integer32; cd : in Array_of_Brackets;
                silent : in boolean; finsum : out Natural_Number );

  -- DESCRIPTION :
  --   Creates the intersection poset defined by the nb brackets in cd
  --   for planes in n-space and resolves the intersection condition
  --   imposed by the brackets in cd.

  -- ON ENTRY :
  --   n        the ambient dimension where the solution planes live;
  --   nb       the number of intersection conditions, defined by brackets;
  --   cd       array of range 1..nb with the conditions as brackets;
  --   silent   if true, then no output will be written to screen.

  -- ON RETURN :
  --   finsum   the final sum of solutions.

  procedure Resolve_Intersection_Condition ( n : in natural32 );

  -- DESCRIPTION :
  --   Interactive procedure to resolve a Schubert condition in n-space.
  --   Prompts the user for a condition and shows its resolution on screen.

  function Get_Intersection_Conditions 
              ( k : natural32 ) return Standard_Natural_VecVecs.Link_to_VecVec;

  -- DESCRIPTION :
  --   Prompts the user for the number of intersection conditions.

  procedure Read_Intersection_Conditions
              ( ip : in Standard_Natural_Vectors.Vector;
                rows,cols : out Standard_Natural_Vectors.Vector );

  -- DESCRIPTION :
  --   Interactive routine to read two brackets representing a
  --   Schubert intersection condition.  As long as they do not form
  --   a happy configuration, the users is prompted to re-enter.

  -- ON ENTRY :
  --   ip       the identity permutation.

  -- ON RETURN :
  --   rows     position of rows of white checkers;
  --   cols     position of columns of white checkers.

  procedure Write_Results
              ( file : in file_type; n,k : in integer32;
                q,rows,cols : in Standard_Natural_Vectors.Vector;
                minrep : in boolean;
                cnds : in Standard_Natural_VecVecs.Link_to_VecVec;
                vfs : in Standard_Complex_VecMats.VecMat;
                sols : in Solution_List; fsys : out Link_to_Poly_Sys );

  -- DESCRIPTION :
  --   Writes the polynomial system and the solutions to file.

  -- ON ENTRY :
  --   file     output file, must be opened for output;
  --   n        ambient dimension;
  --   k        dimension of the solution planes;
  --   q        permutation defines the location of the black checkers;
  --   rows     row positions for white checkers
  --   cols     columns of white checkers of resolved condition;
  --   minrep   if an efficient problem was use to solve the problem;
  --   cnds     conditions kept fixed during flag continuation;
  --   vfs      fixed flags, vfs'range = cnds'range;
  --   sols     solution k-planes.

  -- ON RETURN :
  --   fsys     the polynomial system representing the conditions.

  function Random_Flags
             ( n,m : integer32 ) return Standard_Complex_VecMats.VecMat;

  -- DESCRIPTION :
  --   Returns a vector of range 1..m with n-dimensional random flags.

  function Read_Flags
             ( file : file_type; n,m : integer32 )
             return Standard_Complex_VecMats.VecMat;

  -- DESCRIPTION :
  --   Reads m n-by-n complex matrices from file
  --   and returns a vector of range 1..m of n-by-n complex matrices.

  function Prompt_for_Generic_Flags
             ( n,m : integer32 ) return Standard_Complex_VecMats.VecMat;

  -- DESCRIPTION :
  --   The user is prompted to make a choice between having the
  --   computer generate a vector of range 1..m with n-dimensional flags,
  --   or to input those m flags, either from standard input,
  --   or to be read from file.

  procedure Run_Moving_Flag_Continuation ( n,k : in integer32 );

  -- DESCRIPTION :
  --   Prompts the users first for rows, columns, and the third fixed
  --   intersection condition on k-planes and n-space before calling
  --   the other Run_Moving_Flag_Continuation below.

  procedure Reporting_Moving_Flag_Continuation
              ( n,k : in integer32; tol : in double_float;
                rows,cols : in Standard_Natural_Vectors.Vector;
                minrep : in boolean;
                cnds : in Standard_Natural_VecVecs.Link_to_VecVec );

  -- DESCRIPTION :
  --   Runs the Littlewood-Richardson homotopies to compute k-planes
  --   meeting generic flags in n-space along a specific attitude.
  --   All output is written to a solution file.

  -- ON ENTRY :
  --   n        ambient dimension;
  --   k        dimension of the solution planes;
  --   tol      tolerance on the residual of the original problem;
  --   rows     row positions for white checkers;
  --   cols     columns of white checkers of resolved condition;
  --   minrep   if an efficient problem formulation is to be used;
  --   cnds     conditions kept fixed during flag continuation.

  procedure Reporting_Moving_Flag_Continuation
              ( file : in file_type;
                n,k : in integer32; tol : in double_float;
                rows,cols : in Standard_Natural_Vectors.Vector;
                minrep : in boolean;
                cnds : in Standard_Natural_VecVecs.Link_to_VecVec );

  -- DESCRIPTION :
  --   Runs the Littlewood-Richardson homotopies to compute k-planes
  --   meeting generic flags in n-space along a specific attitude.
  --   All output is written to a solution file.

  -- ON ENTRY :
  --   file     must be opened for output;
  --   n        ambient dimension;
  --   k        dimension of the solution planes;
  --   tol      tolerance on the residual of the original problem;
  --   rows     row positions for white checkers;
  --   cols     columns of white checkers of resolved condition;
  --   minrep   if an efficient problem formulation is to be used;
  --   cnds     conditions kept fixed during flag continuation.

  procedure Reporting_Moving_Flag_Continuation
              ( file : in file_type; tune : in boolean;
                n,k : in integer32; tol : in double_float;
                rows,cols : in Standard_Natural_Vectors.Vector;
                minrep : in boolean;
                cnds : in Standard_Natural_VecVecs.Link_to_VecVec;
                sols : out Solution_list; fsys : out Link_to_Poly_Sys;
                flags : out Standard_Complex_VecMats.VecMat );

  -- DESCRIPTION :
  --   Runs the Littlewood-Richardson homotopies to compute k-planes
  --   meeting generic flags in n-space along a specific attitude.
  --   All output is written to a solution file.

  -- ON ENTRY :
  --   file     must be opened for output;
  --   tune     flag for interactive tuning of the parameters if true,
  --            if false, then tuning is not done;
  --   n        ambient dimension;
  --   k        dimension of the solution planes;
  --   rows     row positions for white checkers
  --   cols     columns of white checkers of resolved condition;
  --   minrep   if an efficient problem formulation is to be used;
  --   cnds     conditions kept fixed during flag continuation.

  -- ON RETURN :
  --   sols     the solution planes;
  --   fsys     polynomial system that represents the conditions;
  --   flags    the coordinates for the fixed random flags.

  procedure Set_Symbol_Table
              ( n,k : in integer32;
                p,rows,cols : in Standard_Natural_Vectors.Vector );

  -- DESCRIPTION :
  --   Initializes the symbol table for a k-plane in n-space, for
  --   black and white checkers respectively defined by p and (rows,cols).

  -- IMPORTANT :
  --   This initialization must be done for running cheater's homotopy,
  --   using start solutions of generic problems read from file.

  procedure Scan_for_Start_Schubert_Problem
              ( file : in file_type; n : in integer32;
                vf : out Standard_Complex_VecMats.VecMat;
                p : out Link_to_Poly_Sys; sols : out Solution_List;
                fail : out boolean );

  -- DESCRIPTION :
  --   A Schubert problem consists of a set of fixed flags in n-space,
  --   a polynomial system and a list of solutions.
  --   If fail is false on return, then (vf,p,sols) define a start
  --   Schubert problem stored as the output of Littlewood-Richardson
  --   homotopies on the given file.

  procedure Run_Cheater_Flag_Homotopy
              ( n,k : in integer32;
                rows,cols : in Standard_Natural_Vectors.Vector;
                cnds : in Standard_Natural_VecVecs.Link_to_VecVec;
                inpt : in boolean );

  -- DESCRIPTION :
  --   Runs a cheater's homotopy from a generic instance to either other
  --   random flags or to specific flags entered by the user.

  -- ON ENTRY :
  --   n        ambient dimension;
  --   k        dimension of the solution planes;
  --   rows     row positions for white checkers
  --   cols     columns of white checkers of resolved condition;
  --   cnds     conditions kept fixed during flag continuation;
  --   inpt     if true, then user will give fixed flags,
  --            if false, then user will generate random flags.

  procedure Resolve_Schubert_Problem
              ( file : in file_type;
                n,k : in integer32; cnd : in Array_of_Brackets;
                flags : in Standard_Complex_VecMats.VecMat );

  -- DESCRIPTION :
  --   Resolves the Schubert problem defined by the brackets in cnd
  --   on k-planes in n-space for the given flags.

  -- REQUIRED : flags'range = 1..cnd'last-2.

  -- ON INPUT :
  --   file     for extra output;
  --   n        ambient space;
  --   k        dimension of the solution planes;
  --   cnt      intersection conditions;
  --   flags    random flags. 

  procedure Resolve_Schubert_Problem
              ( n,k : in integer32; bm : in Bracket_Monomial );

  -- DESCRIPTION :
  --   Prompts the user for the name of the output file and for other
  --   execution parameters and then resolves the Schubert problem.

  -- ON ENTRY :
  --   n        ambient space;
  --   k        dimension of the solution planes;
  --   bm       product of k-brackets, with conditions on the k-planes.

  procedure Solve_Schubert_Problems ( n : in integer32 );

  -- DESCRIPTION :
  --   Interactive procedure to compute solutions to Schubert problems
  --   in n-space.  Prompts the user for data: for intersections conditions
  --   on k-planes in n-space and resolve the Schubert problem.

end Drivers_for_Schubert_Induction;
