defmodule Issues.GithubIssues do
  require Logger
  @user_agent [{"User-Agent", "Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  defp handle_response(%{status_code: 200, body: body}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(response.body) end
    {:ok, :jsx.decode body}
  end

  defp handle_response(%{status_code: _, body: body}) do
    {:error, body}
  end
end
