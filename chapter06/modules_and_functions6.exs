defmodule Chop do
  def guess(actual, range = left..right) do
    guess = div(left+right, 2)
    IO.puts "Is it #{guess}"
    guess(actual, guess, range)
  end

  defp guess(actual, guess, left.._right) when actual < guess do
    guess(actual, left..guess-1)
  end

  defp guess(actual, guess, _left..right) when actual > guess do
    guess(actual, guess+1..right)
  end

  defp guess(actual, actual, _range) do
    IO.puts actual
  end
end

Chop.guess(273, 1..1000)
