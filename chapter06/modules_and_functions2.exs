defmodule Math do
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: n * factorial(n - 1)

  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

IO.puts "factorial(5) should be 120, actual: #{Math.factorial(5)}"
IO.puts "factorial(10) should be 3628800, actual: #{Math.factorial(10)}"
IO.puts "sum(10) should be 55, actual: #{Math.sum(10)}"
IO.puts "len([1,2,3,4]) should be 4, actual: #{Math.len([1,2,3,4])}"
IO.puts "gcd(10, 5) should be 5, actual: #{Math.gcd(10, 5)}"
IO.puts "gcd(10, 3) should be 1, actual: #{Math.gcd(10, 3)}"
IO.puts "gcd(20, 16) should be 4, actual: #{Math.gcd(20, 16)}"

defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a", "b")
Example.func("a", "b", "c")
Example.func("a", "b", "c", "d")
