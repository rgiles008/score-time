defmodule GitScore.Repo do
  use Ecto.Repo,
    otp_app: :git_score,
    adapter: Ecto.Adapters.Postgres
end
