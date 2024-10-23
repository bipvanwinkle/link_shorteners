defmodule LinkMaker.Repo do
  use Ecto.Repo,
    otp_app: :link_maker,
    adapter: Ecto.Adapters.Postgres
end
