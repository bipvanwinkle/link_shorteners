defmodule LinkMaker.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :key, :string
      add :source, :string
      add :destination, :string

      timestamps(type: :utc_datetime)
    end
  end
end
