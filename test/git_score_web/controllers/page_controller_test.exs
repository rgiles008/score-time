defmodule GitScoreWeb.PageControllerTest do
  use GitScoreWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Lets get some user scores"
  end
end
