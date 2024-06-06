defmodule Pesto.Repo do
  use Ecto.Repo,
    otp_app: :pesto,
    adapter: Ecto.Adapters.Postgres
end
