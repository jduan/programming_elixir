defmodule Issues.TableFormatter do
  def print_table_for_columns(rows, headers) do
    columns = split_into_columns(rows, headers)
    widths = widths_of(headers, columns)
    format = format_for(widths)

    puts_one_line_in_columns(format, headers)
    IO.puts separator(widths)
    puts_in_columns(format, columns)
  end

  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows do
        printable row[header]
      end
    end
  end

  defp printable(str) when is_binary(str), do: str
  defp printable(str), do: to_string(str)

  def widths_of(headers, columns) do
    headers_and_columns = List.zip([headers, columns])
    |> Enum.map(fn {header, column} -> [to_string(header) | column] end)
    for column <- headers_and_columns do
      column
      |> Enum.map(&String.length/1)
      |> Enum.max
    end
  end

  def format_for(widths) do
    Enum.map_join(widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(widths) do
    Enum.map_join(widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_one_line_in_columns(format, headers) do
    :io.format(format, headers)
  end

  def puts_in_columns(format, columns) do
    columns
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(format, &1))
  end
end
