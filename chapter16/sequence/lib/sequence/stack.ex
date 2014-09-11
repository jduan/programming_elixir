defmodule Sequence.Stack do
  use GenServer

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, item}, lst) do
    {:noreply, [item|lst]}
  end
end
