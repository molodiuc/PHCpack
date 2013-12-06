with text_io;                            use text_io;
with Standard_Floating_Poly_Systems;     use Standard_Floating_Poly_Systems;

package Standard_Floating_Poly_Systems_io is

-- DESCRIPTION :
--   This package provides a very basic interface to the input/output of
--   polynomial systems with real standard floating-point coefficients,
--   using the available i/o for systems with complex coefficients.
--   The "very basic" means that imaginary parts of coefficients are
--   simply ignored.

  procedure get ( p : out Link_to_Poly_Sys );
  procedure get ( file : in file_type; p : out Link_to_Poly_Sys );

  -- DESCRIPTION :
  --   Interactive input of a polynomial system, given by the user either
  --   via a file name or via standard input.

  procedure put ( p : in Poly_Sys );
  procedure put ( file : in file_type; p : in Poly_Sys );

  -- DESCRIPTION :
  --   Writes the polynomial system p to standard output or to file.

end Standard_Floating_Poly_Systems_io;
