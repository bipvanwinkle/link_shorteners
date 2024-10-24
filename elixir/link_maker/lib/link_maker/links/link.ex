defmodule LinkMaker.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :key, :source, :destination, :inserted_at, :updated_at]}
  schema "links" do
    field :key, :string
    field :source, :string
    field :destination, :string
    field :host, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:key, :source, :destination, :host])
    |> validate_required([:destination, :host])
  end
end
