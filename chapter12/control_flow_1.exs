ExUnit.start

defmodule Test do
  use ExUnit.Case

  test "fizzbuzz" do
    assert Play.fizzbuzz(10) ==
      [1, 2, "fizz", 4, "buzz", "fizz", 7, 8, "fizz", "buzz"]
  end
end

defmodule Play do
  def fizzbuzz(n) when n > 0 do
    for x <- 1..n do
      cond do
        rem(x, 3) == 0 and rem(x, 5) == 0 -> "fizzbuzz"
        rem(x, 3) == 0 -> "fizz"
        rem(x, 5) == 0 -> "buzz"
        true -> x
      end
    end
  end
end
