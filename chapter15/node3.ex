defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
      after @interval ->
        if length(clients) > 0 do
          IO.puts "tick"
          last_pid = List.last clients
          clients = List.delete clients, last_pid
          send last_pid, {:tick}
          generator([last_pid|clients])
        else
          IO.puts "no clients yet"
          generator(clients)
        end
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver
    end
  end
end
