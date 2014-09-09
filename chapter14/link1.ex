import :timer, only: [sleep: 1]

defmodule Link1 do
  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn(Link1, :sad_function, [])
    receive do
      msg -> IO.puts "message received: #{msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Link1.run
