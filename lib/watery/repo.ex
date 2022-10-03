defmodule Watery.Repo do
  use Ecto.Repo,
    otp_app: :watery,
    adapter: Ecto.Adapters.Postgres
end
