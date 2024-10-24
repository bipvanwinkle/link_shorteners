defmodule LinkMaker.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :key, :text, default: fragment("generate_key(6)"), null: false
      add :host, :text, null: false

      add :destination, :text

      timestamps(type: :utc_datetime)
    end

    execute """
      ALTER TABLE public.links ADD COLUMN source TEXT GENERATED ALWAYS AS (host ||  '/' || key) STORED
    """

    create unique_index(:links, [:key])
  end
end
