defmodule Testpow.Repo do
  use Ecto.Repo,
    otp_app: :testpow,
    adapter: Ecto.Adapters.Postgres
end
