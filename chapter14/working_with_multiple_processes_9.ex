# Run this script in the directory of this script.
defmodule CatFinder do
  def find(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, filename, scheduler_pid} ->
        send scheduler_pid, {:answer, filename, find_cat(filename)}
        find(scheduler)
      {:shutdown} ->
        IO.puts "CatFinder shutting down"
    end
  end

  defp find_cat(filename) do
    length(Regex.scan(~r/cat/, File.read!(filename)))
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |>
    Enum.map(fn _ ->
      spawn_link(module, func, [self])
    end)
    |>
    schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, worker_pid} when length(queue) > 0 ->
        [head|tail] = queue
        send worker_pid, {:fib, head, self}
        schedule_processes(processes, tail, results)
      {:ready, worker_pid} ->
        send worker_pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, worker_pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end
      {:answer, n, result} ->
        schedule_processes(processes, queue, [{n, result}|results])
    end
  end
end

to_process = File.ls!(".")

Enum.each 1..5, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,
                             [num_processes, CatFinder, :find, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #     time (s)"
  end

  :io.format "~2B    ~.2f~n", [num_processes, time/1000000.0]
end
