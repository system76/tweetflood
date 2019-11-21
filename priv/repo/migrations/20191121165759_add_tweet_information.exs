defmodule Tweetflood.Repo.Migrations.AddTweetInformation do
  use Ecto.Migration

  def change do
    alter table(:tweets) do
      add :user_avatar, :string
      add :user_name, :string
      add :user_tag, :string
    end
  end
end
