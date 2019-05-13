defmodule Sample do
  def x + y, do: [x, y]
  def x - y, do: [y, x]

  defmodule Dynamic do
    defmodule A do
      def f, do: "foo"
    end
    defmodule B do
      def f, do: "bar"
    end
  end

  def call(module) do
    module.f
  end
end

