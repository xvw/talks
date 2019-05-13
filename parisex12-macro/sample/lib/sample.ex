defmodule Sample do

  defmacro my_unless(predicate, do: expression) do
    quote do
      if(! unquote(predicate), do: unquote(expression))
    end
  end
  
  def x + y, do: [x, y]
  def x - y, do: [y, x]

          
          
end

