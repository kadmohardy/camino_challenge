defmodule CaminoChallenge.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :camino_challenge,
    adapter: Ecto.Adapters.Postgres
end
