with Standard_Natural_Numbers;           use Standard_Natural_Numbers;

package body Degrees_in_Sets_of_Unknowns is

  function Degree ( t : Term; s : Set ) return integer32 is

    sum : integer32 := 0;

  begin
    if Extent_Of(s) > 0 then
      for i in t.dg'range loop
        if Is_In(s,natural32(i))
         then sum := sum + integer32(t.dg(i));
        end if;
      end loop;
    end if;
    return sum;
  end Degree;

  function Degree ( p : Poly; s : Set ) return integer32 is

    res : integer32 := -1;

    procedure Degree_Term ( t : in Term; continue : out boolean ) is

      sum : constant integer32 := Degree(t,s);

    begin
      if sum > res
       then res := sum;
      end if;
      continue := true;
    end Degree_Term;
    procedure Degree_Terms is new Visiting_Iterator(Degree_Term);

  begin
    Degree_Terms(p);
    return res;
  end Degree;

  function Degree_Table ( p : Poly_Sys; z : Partition )
                        return Standard_Integer_Matrices.Matrix is

    res : Standard_Integer_Matrices.Matrix
            (p'range,integer32(z'first)..integer32(z'last));

  begin
    for i in p'range loop
      for j in z'range loop
        res(i,integer32(j)) := Degree(p(i),z(j));
      end loop;
    end loop;
    return res;
  end Degree_Table;

  function Degree_Table ( p : Poly_Sys; z : Partition )
                        return Standard_Integer64_Matrices.Matrix is

    res : Standard_Integer64_Matrices.Matrix
            (p'range,integer32(z'first)..integer32(z'last));

  begin
    for i in p'range loop
      for j in z'range loop
        res(i,integer32(j)) := integer64(Degree(p(i),z(j)));
      end loop;
    end loop;
    return res;
  end Degree_Table;

end Degrees_in_Sets_of_Unknowns;
