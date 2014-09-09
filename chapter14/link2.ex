import :timer, only: [sleep: 1]

defmodule Link2 do
  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    # Process.flag(:trap_exit, true)
    spawn_link(Link2, :sad_function, [])
    receive do
      msg -> IO.puts "message received: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Link2.run
