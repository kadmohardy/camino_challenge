defmodule CaminoChallengeWeb.Api.PessoaFisicaController do
  use CaminoChallengeWeb, :controller
  alias CaminoChallenge.Api.Params.PessoaFisicaParams
  alias CaminoChallenge.Pessoas.Entities.PessoaFisica
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository
  alias CaminoChallenge.Pessoas.Services.CreatePessoaFisica
  require Logger
  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    pessoas_fisicas = PessoaFisicaRepository.list_pessoas_fisicas()
    render(conn, "index.json", pessoas_fisicas: pessoas_fisicas)
  end

  def create(conn, %{"pessoa_fisica" => pessoa_fisica_params}) do
    changeset = PessoaFisicaParams.from(pessoa_fisica_params, with: &PessoaFisicaParams.child/2)

    if changeset.valid? do
      with {:ok, %PessoaFisica{} = pessoa_fisica} <-
             CreatePessoaFisica.execute(pessoa_fisica_params) do
        conn
        |> put_status(:created)
        |> render("show.json", pessoa_fisica: pessoa_fisica)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(CaminoChallengeWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end
end
