defmodule TweetfloodWeb.ApiControllerTest do
  use TweetfloodWeb.ConnCase

  test "GET /api", %{conn: conn} do
    tweet = insert(:tweet)
    conn = get(conn, "/api")

    assert json_response(conn, 200) == %{
             "count" => 1,
             "tweets" => [
               %{
                 "text" => tweet.text,
                 "user_id" => tweet.user_id,
                 "user_avatar" => tweet.user_avatar,
                 "user_name" => tweet.user_name,
                 "user_tag" => tweet.user_tag
               }
             ]
           }
  end
end
