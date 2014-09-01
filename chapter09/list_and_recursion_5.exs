require Integer

ExUnit.start

defmodule MyEnum do
  def all?([], _func), do: true
  def all?(lst, func) do
    [head|tail] = lst
    func.(head) && all?(tail, func)
  end

  def each([], _func), do: :ok
  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([head|tail], func) do
    if func.(head) do
      [head|filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split([], _n), do: {[], []}
  def split(list, 0) do
    {[], list}
  end
  def split([head|tail], n) do
    {first, second} = split(tail, n-1)
    {[head|first], second}
  end

  def take([], _n), do: []
  def take(_list, 0), do: []
  def take([head|tail], n) do
    [head|take(tail, n-1)]
  end
end

defmodule Test do
  use ExUnit.Case

  test "all?" do
    assert MyEnum.all?([1,2,3,4,5], &(&1 < 6))
    refute MyEnum.all?([1,2,3,4,5], &(&1 < 3))
  end

  test "each" do
    assert MyEnum.each([1,2,3,4,5], &IO.inspect/1) == :ok
  end

  test "filter" do
    assert MyEnum.filter([1,2,3,4,5], &Integer.even?/1) == [2,4]
    assert MyEnum.filter([1,2,3,4,5], &Integer.odd?/1) == [1,3,5]
  end

  test "split" do
    assert MyEnum.split([], 2) == {[], []}
    assert MyEnum.split([1], 2) == {[1], []}
    assert MyEnum.split([1,2], 2) == {[1,2], []}
    assert MyEnum.split([1,2,3,4,5], 2) == {[1,2], [3,4,5]}
  end

  test "take" do
    assert MyEnum.take([], 3) == []
    assert MyEnum.take([1,2,3], 0) == []
    assert MyEnum.take([1,2,3], 2) == [1,2]
    assert MyEnum.take([1,2,3], 20) == [1,2,3]
    assert MyEnum.take('pragmatic', 6) == 'pragma'
  end
end
