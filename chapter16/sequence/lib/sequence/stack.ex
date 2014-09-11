defmodule Sequence.Stack do
  use GenServer

  # external API #

  def start_link(lst) do
    GenServer.start_link(__MODULE__, lst, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def terminate(reason, state) do
    IO.puts "reason: #{inspect reason}, state: #{inspect state}"
  end

  # internal API #

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, item}, lst) do
    {:noreply, [item|lst]}
  end
end
