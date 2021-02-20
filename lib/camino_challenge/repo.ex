defmodule CaminoChallenge.Repo do
  use Ecto.Repo,
    otp_app: :camino_challenge,
    adapter: Ecto.Adapters.Postgres
end
