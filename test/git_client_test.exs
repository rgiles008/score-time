defmodule GitClientTest do
  use ExUnit.Case, async: false

  alias GitScore.GitClient

  describe "GitClient.get_events/1" do
    test "should return :error with invalid github repo owner" do
      {event, score} = GitClient.get_events("error")
      assert event == [{"IssueCommentEvent", 1}]
      assert score == 0
    end

    test "should successfully return event and total with valid github user" do
      {event, score} = GitClient.get_events("rgiles008")
      assert event == [{"CreateEvent", 4}, {"IssueCommentEvent", 1}, {"PushEvent", 5}]
      assert score == 33
    end
  end
end