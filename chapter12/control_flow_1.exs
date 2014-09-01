ExUnit.start

defmodule Test do
  use ExUnit.Case

  test "fizzbuzz" do
    assert Play.fizzbuzz(10) ==
      [1, 2, "fizz", 4, "buzz", "fizz", 7, 8, "fizz", "buzz"]
  end
end

defmodule Play do
  # def fizzbuzz(n) when n > 0 do
  #   for x <- 1..n do
  #     case {rem(x, 3), rem(x, 5)} do
  #       {0, 0}-> "fizzbuzz"
  #       {0, _}-> "fizz"
  #       {_, 0}-> "buzz"
  #       _ -> x
  #     end
  #   end
  # end

  def fizzbuzz(n) when n > 0 do
    for x <- 1..n do
      do_fizzbuzz(rem(x,3), rem(x,5), x)
    end
  end

  defp do_fizzbuzz(0, 0, _), do: "fizzbuzz"
  defp do_fizzbuzz(0, _, _), do: "fizz"
  defp do_fizzbuzz(_, 0, _), do: "buzz"
  defp do_fizzbuzz(_, _, n), do: n
end
