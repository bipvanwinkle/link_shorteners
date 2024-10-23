defmodule LinkMaker.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LinkMaker.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        destination: "some destination",
        key: "some key",
        source: "some source"
      })
      |> LinkMaker.Links.create_link()

    link
  end
end
