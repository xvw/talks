defmodule SampleTest do
  use ExUnit.Case
  doctest Sample

  test "Test for +" do
    import Sample
    assert add(m(100), cm(100)) == m(101)
  end

end
