defmodule Tweetflood.Repo.Migrations.CreateTweetsTable do
  use Ecto.Migration

  def change do
    create table(:tweets, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :text, :text, null: false
      add :user_id, :bigint, null: false
    end
  end
end
