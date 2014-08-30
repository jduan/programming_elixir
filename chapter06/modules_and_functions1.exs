defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quadruple(n) do
    double double n
  end
end

IO.puts "double(5) should be 10, actual: #{Times.double(5)}"
IO.puts "triple(5) should be 15, actual: #{Times.triple(5)}"
IO.puts "quadruple(5) should be 20, actual: #{Times.quadruple(5)}"
