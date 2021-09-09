defmodule GitScoreWeb.PageController do
  use GitScoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
