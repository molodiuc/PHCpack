with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Random_Numbers;            use Standard_Random_Numbers;

package body Standard_Random_Vectors is

  function Random_Vector ( first,last,low,upp : integer32 )
                         return Standard_Integer_Vectors.Vector is

    res : Standard_Integer_Vectors.Vector(first..last);

  begin
    for i in res'range loop
      res(i) := Random(low,upp);
    end loop;
    return res;
  end Random_Vector;

  function Random_Vector ( first,last : integer32; low,upp : integer64 )
                         return Standard_Integer64_Vectors.Vector is

    res : Standard_Integer64_Vectors.Vector(first..last);

  begin
    for i in res'range loop
      res(i) := Random(low,upp);
    end loop;
    return res;
  end Random_Vector;

  function Random_Vector ( first,last : integer32 )
                         return Standard_Floating_Vectors.Vector is

    res : Standard_Floating_Vectors.Vector(first..last);

  begin
    for i in res'range loop
      res(i) := Random;
    end loop;
    return res;
  end Random_Vector;

  function Random_Vector ( first,last : integer32; m : natural32 )
                         return Standard_Floating_Vectors.Vector is

    res : Standard_Floating_Vectors.Vector(first..last);
    r : double_float;

  begin
    for i in res'range loop
      res(i) := Random_Magnitude(m);
      r := Random;
      if r < 0.0
       then res(i) := -res(i);
      end if;
    end loop;
    return res;
  end Random_Vector;

  function Random_Vector ( first,last : integer32 )
                         return Standard_Complex_Vectors.Vector is

    res : Standard_Complex_Vectors.Vector(first..last);

  begin
    for i in res'range loop
      res(i) := Random1;
    end loop;
    return res;
  end Random_Vector;

  function Random_Vector ( first,last : integer32; m : natural32 )
                         return Standard_Complex_Vectors.Vector is

    res : Standard_Complex_Vectors.Vector(first..last);

  begin
    for i in res'range loop
      res(i) := Random_Magnitude(m);
    end loop;
    return res;
  end Random_Vector;

end Standard_Random_Vectors;
