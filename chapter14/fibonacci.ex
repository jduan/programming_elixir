defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, scheduler_pid} ->
        send scheduler_pid, {:answer, n, fibonacci(n)}
        fib(scheduler)
      {:shutdown} ->
        IO.puts "FibSolver shutting down"
    end
  end

  defp fibonacci(0), do: 0
  defp fibonacci(1), do: 1
  defp fibonacci(n) when n > 1, do: fibonacci(n-1) + fibonacci(n-2)
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

to_process = [37, 37, 37, 37, 37, 37]

Enum.each 1..5, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,
                             [num_processes, FibSolver, :fib, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #     time (s)"
  end

  :io.format "~2B    ~.2f~n", [num_processes, time/1000000.0]
end
