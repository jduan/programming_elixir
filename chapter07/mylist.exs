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

  def reduce([], accumulator, _func), do: accumulator
  def reduce([head|tail], accumulator, func) do
    reduce(tail, func.(head, accumulator), func)
  end

  def mapsum([], _func), do: 0
  def mapsum([head|tail], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([head]), do: head
  def max([head|tail]) do
    Kernel.max(head, max(tail))
  end

  def caesar(lst, n) do
    add = fn char ->
      new_char = char + n
      if new_char > ?z do
        new_char - 26
      else
        new_char
      end
    end
    map(lst, add)
  end

  def swap([]), do: []
  def swap([hd1, hd2 | tail]), do: [hd2, hd1 | swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
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
IO.inspect MyList.reduce([1,2,3,4], 0, &(&1 + &2))
IO.inspect MyList.reduce([1,2,3,4], 1, &(&1 * &2))
IO.inspect MyList.mapsum([1,2,3,4], &(&1 * &1))
IO.inspect MyList.max([1,2,3,4])
IO.inspect MyList.max([1,2,7,3,4])
IO.inspect MyList.caesar('ryvkve', 13)
IO.inspect MyList.swap([])
IO.inspect MyList.swap([1,2,3,4])

defmodule WeatherHistory do
  def for_location_27([]), do: []
  def for_location_27([ head = [_time, 27, _temp, _rain] | tail ]) do
    [ head | for_location_27(tail) ]
  end
  def for_location_27([_|tail]), do: for_location_27(tail)

  def for_location([], _location), do: []
  def for_location([ head = [_time, location, _temp, _rain] | tail ], location) do
    [ head | for_location(tail, location) ]
  end
  def for_location([_|tail], location), do: for_location(tail, location)
end

test_data = [
  [1366225622, 26, 15, 0.125],
  [1366225622, 27, 15, 0.45],
  [1366225622, 28, 21, 0.25],
  [1366229222, 26, 19, 0.081],
  [1366229222, 27, 17, 0.468],
  [1366229222, 28, 15, 0.60],
  [1366232822, 26, 22, 0.095],
  [1366232822, 27, 21, 0.05],
  [1366232822, 28, 24, 0.03],
  [1366236422, 26, 17, 0.025]
]

IO.inspect WeatherHistory.for_location_27(test_data)
IO.inspect WeatherHistory.for_location(test_data, 28)
