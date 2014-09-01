ExUnit.start

defmodule Primes do
  def upto(n) do
    for x <- 2..n, prime?(x), do: x
  end

  defp prime?(2), do: true
  defp prime?(n) do
    Enum.all?(2..n-1, &(rem(n, &1) != 0))
  end
end

defmodule Test do
  use ExUnit.Case

  test "upto" do
    assert Primes.upto(10) == [2,3,5,7]
    assert Primes.upto(40) == [2,3,5,7,11,13,17,19,23,29,31,37]
  end
end
