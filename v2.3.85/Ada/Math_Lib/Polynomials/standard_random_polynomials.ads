with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Complex_Numbers;          use Standard_Complex_Numbers;
with Standard_Complex_Polynomials;
with Standard_Complex_Laurentials;

package Standard_Random_Polynomials is

-- DESCRIPTION :
--   This package provides some routines to generate random sparse
--   and dense polynomials in several variables and of various degrees.

  function Random_Coefficient ( c : natural32 ) return Complex_Number;
 
  -- DESCRIPTION :
  --   Returns a coefficient for a monomial, as follows:
  --     c = 0 : on complex unit circle (this is default);
  --     c = 1 : the constant one (useful for templates);
  --     c = 2 : a random float between -1.0 and +1.0.

  function Random_Monomial
             ( n,d : natural32 ) return Standard_Complex_Polynomials.Term;
  function Random_Monomial
             ( n : natural32; d,e : integer32 )
             return Standard_Complex_Laurentials.Term;

  -- DESCRIPTION :
  --   Returns one random monomial in n variables of degree <= d,
 --    or between d and e for Laurent monomial. The coefficient equals one.

  function Random_Term 
             ( n,d,c : natural32 ) return Standard_Complex_Polynomials.Term;
  function Random_Term 
             ( n : natural32; d,e : integer32; c : natural32 ) 
             return Standard_Complex_Laurentials.Term;

  -- DESCRIPTION :
  --   Returns a random term of n variables and with degree <= d,
  --   or degree between d and e (e >= d) for Laurent monomials,
  --   and coefficient generated by Random_Coefficient(c).

  function Random_Dense_Poly
             ( n,d,c : natural32 ) return Standard_Complex_Polynomials.Poly;
  function Random_Dense_Poly
             ( n : natural32; d,e : integer32; c : natural32 )
             return Standard_Complex_Laurentials.Poly;

  -- DESCRIPTION :
  --   Returns a dense polynomial of degree d (or between d and e for
  --   Laurent polynomials) in n variables, with
  --   all monomials up to degree d have a nonzero coefficient,
  --   generated by Random_Coefficient(c).

  function Random_Sparse_Poly
             ( n,d,m,c : natural32 ) return Standard_Complex_Polynomials.Poly;
  function Random_Sparse_Poly
             ( n : natural32; d,e : integer32; m,c : natural32 )
             return Standard_Complex_Laurentials.Poly;

  -- DESCRIPTION :
  --   Returns a sparse polynomial of degree d (or between d and e for
  --   Laurent polynomials) in n variables, where no
  --   more than m monomials of degree <= d have a nonzero coefficient,
  --   generated by Random_Coefficient(c).

end Standard_Random_Polynomials;
