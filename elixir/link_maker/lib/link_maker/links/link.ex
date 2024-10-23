defmodule LinkMaker.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :key, :string
    field :source, :string
    field :destination, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:key, :source, :destination])
    |> validate_required([:key, :source, :destination])
  end
end
