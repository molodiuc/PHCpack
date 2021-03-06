with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer64_Vectors;
with Standard_Integer64_Matrices;        use Standard_Integer64_Matrices;

package Standard_Lattice_Polytopes is

-- DESCRIPTION :
--   A lattice polytope is spanned by lattice points, with coordinates
--   standard 64-bit integer numbers.  The operations in this package
--   implement the giftwrapping algorithm for the convex hull.

-- INITIAL FACET :

  function Rank ( A : Matrix ) return natural32;

  -- DESCRIPTION :
  --   Returns the rank of the matrix A.  The columns of A contain
  --   the coordinates of the points that span the polytope.
  --   If the rank r is strictly less than A'last(1), then the polytope
  --   is entirely contained in a linear space of dimension r.

  function Normal ( A : Matrix; v : Standard_Integer64_Vectors.Vector )
                  return Standard_Integer64_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns a vector perpendicular to the points spanned by
  --   the face supported by the vector v.

  procedure Inner ( A : in Matrix; k : in integer32;
                    v : in out Standard_Integer64_Vectors.Vector );

  -- DESCRIPTION :
  --   Changes the orientation of the normal v if the inner product
  --   of the k-th point with v is larger than the minimal inner product.

  function Normal ( A : Matrix; v : Standard_Integer64_Vectors.Vector;
                    k : integer32 ) return Standard_Integer64_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the inner normal to the points of A in the face defined by v
  --   and the k-th point of A.

  function Largest_Angle
              ( A : Matrix; f,g : Standard_Integer64_Vectors.Vector )
              return integer32;

  -- DESCRIPTION :
  --   Returns the index of the column in A whose vector starting
  --   at the face defined by f makes the largest angle with the face.

  -- ON ENTRY :
  --   A        matrix with cordinates of the support set;
  --   f        inner normal to a face of the convex hull of A;
  --   g        vector perpendicular to f and the face defined by f.

  function Is_Zero ( v : Standard_Integer64_Vectors.Vector ) return boolean;

  -- DESCRIPTION :
  --   Returns true if the vector v is equals the zero vector.

  procedure Initial_Facet_Normal
              ( A : in Matrix; rnk : out natural32;
                v : out Standard_Integer64_Vectors.Vector );

  -- DESCRIPTION :
  --   Returns in v the inner normal to the first facet
  --   and in rnk the rank of the matrix.

end Standard_Lattice_Polytopes;
