with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Multprec_Complex_Numbers;           use Multprec_Complex_Numbers;
with Multprec_Complex_Poly_Systems;      use Multprec_Complex_Poly_Systems;
with Multprec_Complex_Solutions;         use Multprec_Complex_Solutions;
with Multprec_Continuation_Data;         use Multprec_Continuation_Data;

package Multprec_Path_Tracker is

-- DESCRIPTION :
--   This package implements a path tracker with a next() method
--   for systems and solutions at arbitrary precision.

-- CONSTRUCTORS :

  procedure Init ( s : in Link_to_Solution );

  -- DESRIPTION :
  --   Stores s as the current solution, leaves the homotopy as it is.
  --   This is useful for tracking the next path in the same homotopy.

  procedure Init ( p,q : in Link_to_Poly_sys; deci : in natural32 );
  procedure Init ( p,q : in Link_to_Poly_sys; s : in Link_to_Solution;
                   deci : in natural32 );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).  Fixed default values
  --   will be used for the gamma and k constants in the homotopy.
  --   The number of decimal places in the working precision (deci)
  --   will be used to set the tolerances in the continuation parameters.
  --   The condition of the continuation parameters is set to zero.

  procedure Init ( p,q : in Link_to_Poly_sys;
                   gamma : in Complex_Number; k,deci : in natural32 );
  procedure Init ( p,q : in Link_to_Poly_sys; s : in Link_to_Solution;
                   gamma : in Complex_Number; k,deci : in natural32 );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).
  --   The given gamma and k will be used as constants in the homotopy.
  --   The condition of the continuation parameters is set to zero.
  --   The number of decimal places in the working precision (deci)
  --   will be used to set the tolerances in the continuation parameters.

  procedure Init ( p,q : in Link_to_Poly_sys;
                   gamma : in Complex_Number; k,deci,cp : in natural32 );
  procedure Init ( p,q : in Link_to_Poly_sys; s : in Link_to_Solution;
                   gamma : in Complex_Number; k,deci,cp : in natural32 );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).
  --   The given gamma and k will be used as constants in the homotopy.
  --   The number of decimal places in the working precision (deci)
  --   will be used to set the tolerances in the continuation parameters.
  --   The condition of the continuation parameters is set to cp.

-- SELECTORS :

  function get_current return Link_to_Solution;
  function get_current return Solu_Info;

  -- DESCRIPTION :
  --   Returns the current solution.

  function get_next return Link_to_Solution;

  -- DESCRIPTION :
  --   Does one step of a predictor-corrector method till success.
  --   The default for the target of the continuation parameter t is one.

  function get_next ( target_t : Complex_Number ) return Link_to_Solution;

  -- DESCRIPTION :
  --   Does one step of a predictor-corrector method till success
  --   for the given target of the continuation parameter.

-- DESCTRUCTOR :

  procedure Clear;

  -- DESCRIPTION :
  --   Clears the homotopy data and resets all data.

end Multprec_Path_Tracker;
