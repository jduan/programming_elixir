set1 = Enum.into 1..5, HashSet.new
Set.member? set1, 3
set2 = Enum.into 3..8, HashSet.new
Set.union set1, set2
Set.difference set1, set2
Set.difference set2, set1
Set.intersection set1, set2
