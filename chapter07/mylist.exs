defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head|tail]), do: [head * head | square(tail)]

  def add1([]), do: []
  def add1([head|tail]), do: [head+1 | add1(tail)]

  def map([], _func), do: []
  def map([head|tail], func), do: [func.(head) | map(tail, func)]

  def sum([]), do: 0
  def sum([head|tail]), do: head + sum(tail)
end

IO.inspect MyList.len([])
IO.inspect MyList.len([1,2,3,4])
IO.inspect MyList.square([])
IO.inspect MyList.square([1,2,3,4])
IO.inspect MyList.add1([])
IO.inspect MyList.add1([1,2,3,4])
IO.inspect MyList.map([], &(&1 * &1))
IO.inspect MyList.map([1,2,3,4], &(&1 * &1))
IO.inspect MyList.map([1,2,3,4], &(&1 > 2))
IO.inspect MyList.sum([])
IO.inspect MyList.sum([1,2,3,4])
