defmodule GitScoreWeb.ScoreController do
  use GitScoreWeb, :controller
  alias GitScore.GitClient

  def get_events(conn, params) do
    %{"owner" => owner} = params
    case GitClient.get_events(owner) do
      {:error, message} ->
        render(conn, "error.html", message: message)
      {scores, total} ->
        render(conn, "score.html", scores: scores, owner: owner, total: total)
    end
  end
end