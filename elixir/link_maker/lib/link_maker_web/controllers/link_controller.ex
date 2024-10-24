defmodule LinkMakerWeb.LinkController do
  use LinkMakerWeb, :controller

  alias LinkMaker.Links

  def index(conn, _params) do
    links = Links.list_links()

    json(conn, links)
  end

  def create(conn, %{"destination" => destination}) do
    case Links.create_link(%{"destination" => destination, "host" => "https://bip.me"}) do
      {:ok, new_link} ->
        # Success case: return the new link as JSON
        json(conn, new_link)

      {:error, changeset} ->
        # Error case: return a 422 Unprocessable Entity response with the error messages
        IO.inspect(changeset)

        conn
        |> put_status(:unprocessable_entity)
        # I need to properly handle errors here
        |> json(%{errors: "This didn't work"})
    end
  end
end
