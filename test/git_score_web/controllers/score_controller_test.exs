defmodule GitScoreWeb.ScoreControllerTest do
  use GitScoreWeb.ConnCase

  setup do
    [
      html_body: "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <title>GitScore · Phoenix Framework</title>\n    <link rel=\"stylesheet\" href=\"/css/app.css\"/>\n    <script defer type=\"text/javascript\" src=\"/js/app.js\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n\n              <li><a href=\"/dashboard\">LiveDashboard</a></li>\n\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"/images/phoenix.png\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n    <main role=\"main\" class=\"container\">\n      <p class=\"alert alert-info\" role=\"alert\"></p>\n      <p class=\"alert alert-danger\" role=\"alert\"></p>\n<section>\n  <h2>Github User: rgiles008 </h2>\n  <label> Event points to date:</label>\n[{&quot;CreateEvent&quot;, 4}, {&quot;IssueCommentEvent&quot;, 1}, {&quot;PushEvent&quot;, 5}]\n</section>\n<br/>\n\n<section>\n  <h3>User Events Total</h3>\n  <label>Total points to date: 33</label>\n</section>\n\n    </main>\n  </body>\n</html>\n",
      error_html_body: "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <title>GitScore · Phoenix Framework</title>\n    <link rel=\"stylesheet\" href=\"/css/app.css\"/>\n    <script defer type=\"text/javascript\" src=\"/js/app.js\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n\n              <li><a href=\"/dashboard\">LiveDashboard</a></li>\n\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"/images/phoenix.png\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n    <main role=\"main\" class=\"container\">\n      <p class=\"alert alert-info\" role=\"alert\"></p>\n      <p class=\"alert alert-danger\" role=\"alert\"></p>\n<section>\n  <h2>Github User:  </h2>\n  <label> Event points to date:</label>\n:error\n</section>\n<br/>\n\n<section>\n  <h3>User Events Total</h3>\n  <label>Total points to date: &quot;Error getting user events&quot;</label>\n</section>\n\n    </main>\n  </body>\n</html>\n"
    ]
  end

  describe "ScoreController: /events" do
    test "Should get events from github", fixture do
      conn =
        build_conn()
        |> put_req_header("content_type", "application/json")
        |> post("/events", %{"owner" => "rgiles008"})

      assert conn.status == 200
      assert conn.resp_body == fixture.html_body
    end

    test "should fail given empty params or a non github repo owner", fixture do
      conn =
        build_conn()
        |> put_req_header("content_type", "application/json")
        |> post("/events", %{"owner" => ""})

      assert conn.status == 200
      assert conn.resp_body  == fixture.error_html_body
    end
  end
end