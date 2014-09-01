# Stream.resource(fn -> File.open("/usr/share/dict/words") end,
#                 fn file ->
#                   case IO.read(file, :line) do
#                     line when is_binary(line) -> {line, file}
#                     _ -> nil
#                   end
#                 end,
#                 fn file -> File.close(file) end)
# |> Enum.take 5

defmodule Countdown do
  def sleep(seconds) do
    receive do
      after seconds * 1000 -> nil
    end
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    Stream.resource(
    fn ->
      {_h, _m, s} = :erlang.time
      60 - s - 1
    end,

    fn
      count when count == 0 -> nil;
      count ->
        sleep(1)
        { inspect(count), count - 1 };
    end,

    fn _ -> end
    )
  end
end

counter = Countdown.timer
counter |> Stream.each(&IO.puts/1) |> Enum.take 5
