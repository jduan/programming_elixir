defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %{}, details: "", severity: 1
end

# report = %BugReport{owner: %Customer{name: "Dave", company: "Progmatic"},
#                     details: "broken"}
# put_in(report.owner.company, "PragProg")
#
# update_in(report.owner.name, &("Mr. " <> &1))
