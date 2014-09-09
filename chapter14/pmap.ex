defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(fn e -> spawn(Parallel, :child, [self, e, func]) end)
    |> Enum.map(fn pid ->
      receive do
        # change the following to review the bug
        # {pid, value} -> value
        {^pid, value} -> value
      end
    end)
  end

  def child(parent, element, func) do
    send parent, {self, func.(element)}
  end
end

collection = 1..1000

result = Enum.map(collection, &(&1 * &1))

 Enum.each(1..1000, fn i ->
   if Parallel.pmap(collection, &(&1 * &1)) != result do
     IO.puts "False"
   end
 end)
