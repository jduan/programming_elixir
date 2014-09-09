import :timer, only: [sleep: 1]

defmodule MultipleProcesses do
  def run do
    spawn_link(MultipleProcesses, :child, [self])
    receive_messages
  end

  def receive_messages do
    sleep 500
    IO.puts "waiting for messages"
    receive do
      msg ->
        IO.puts "received: #{msg}"
        receive_messages
    end
  end

  def child(parent) do
    send parent, "hello world"
  end
end

MultipleProcesses.run
