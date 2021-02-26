defmodule CaminoChallengeWeb.Router do
  use CaminoChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", CaminoChallengeWeb.Api, as: :api do
    pipe_through :api

    resources "/pessoas/fisicas", PessoaFisicaController, only: [:index, :create]
    resources "/pessoas/juridicas", PessoaJuridicaController, only: [:index, :create]
    resources "/contratos", ContratoController, only: [:index, :create]
  end
end
