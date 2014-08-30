list_concat = fn lst1, lst2 -> lst1 ++ lst2 end
IO.puts list_concat.([1,2,3], [4,5,6]) == [1,2,3,4,5,6]

sum = fn a, b, c -> a + b + c end
IO.puts sum.(1, 2, 3) == 6

pair_tuple_to_list = fn {a, b} -> [a, b] end
IO.puts pair_tuple_to_list.({8, 7}) == [8,7]
