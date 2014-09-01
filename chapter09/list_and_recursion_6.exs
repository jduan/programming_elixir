ExUnit.start

defmodule MyEnum do
  def flatten([]), do: []
  def flatten([head|tail]) when not is_list(head) do
    [head|flatten(tail)]
  end
  def flatten([head|tail]) do
    flatten(head) ++ flatten(tail)
  end
end

defmodule Test do
  use ExUnit.Case

  test "flatten" do
    assert MyEnum.flatten([ 1, [ 2, 3, [4]  ], 5, [[[6]]] ]) == [1,2,3,4,5,6]
  end
end
