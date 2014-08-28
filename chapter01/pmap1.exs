defmodule Parallel do
  def pmap1(collection, func) do
    collection
    |>
    Enum.map(&(Task.async(fn -> func.(&1) end)))
    |>
    Enum.map(&Task.await/1)
  end
end

IO.puts inspect Parallel.pmap1(1..10000, fn (e) -> e * e end)
