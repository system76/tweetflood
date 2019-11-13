defmodule TweetfloodWeb.TweetControllerTest do
  use TweetfloodWeb.ConnCase

  test "GET / with no tweets", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Tweetflood at 0 tweets"
  end

  test "GET / with tweets", %{conn: conn} do
    tweet = insert(:tweet)

    conn = get(conn, "/")
    response = assert html_response(conn, 200)
    assert response =~ "Tweetflood at 1 tweet"
    assert response =~ tweet.text
  end
end
