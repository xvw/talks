defmodule Sample do

  def cm(x), do: {:distance, :cm, x, 100.0}
  def m(x), do: {:distance, :m, x, 1.0}
  def add({base, ref, x, coeff1}, {base, _,  y, coeff2}) do 
    {base, ref, x + (y * (coeff1 / coeff2)), coeff1}
  end
end

