defmodule SampleTest do
  use ExUnit.Case
  doctest Sample

  test "Test for +" do
    import Kernel, except: [+: 2, -: 2]
    import Sample
    assert (1 + 2) == [1, 2]
    assert (1 - 2) == [2, 1]
  end

end
