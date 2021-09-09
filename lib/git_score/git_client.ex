defmodule GitScore.GitClient do
  @moduledoc """
  Client service using Tentacat to get user events
  """

  @token Application.get_env(:git_score, :github_token)

  def get_events(owner) do
    IO.inspect(@token)
    client = Tentacat.Client.new(%{access_token: @token})
    case Tentacat.Users.Events.list(client, owner) do
      {200, _body, response} ->
        process_user_events(response.body)
      _ ->
        {:error, "Error getting user events"}
    end
  end

  defp process_user_events(body) do
    body
    |> Flow.from_enumerable()
    |> Flow.reduce(fn -> %{} end, fn event, acc ->
      Map.update(acc, event["type"], 1, &(&1 + 1))
    end)
    |> Enum.to_list()
    |> total_user_event_scores()
  end

  defp total_user_event_scores(event_count) do
    score = init_score()

    total_score =
      Enum.map(event_count, fn {event, occurence} ->
        case Map.get(score, event) do
          nil -> score["Default"] * occurence
          score -> score * occurence
        end
      end) |> Enum.sum()

    {event_count, total_score}
  end

  defp init_score() do
    %{
      "PushEvent" => 5,
      "PullRequestReviewCommentEvent" => 4,
      "WatchEvent" => 3,
      "CreateEvent" => 2,
      "Default" => 0
    }
  end
end