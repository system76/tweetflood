defmodule Tweetflood.Repo.Migrations.CreateTweetTimestamps do
  use Ecto.Migration

  def change do
    alter table(:tweets) do
      timestamps()
    end
  end
end
