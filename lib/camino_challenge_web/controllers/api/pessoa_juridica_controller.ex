defmodule CaminoChallengeWeb.Api.PessoaJuridicaController do
  use CaminoChallengeWeb, :controller
  alias CaminoChallenge.Api.Params.PessoaJuridicaParams
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository
  alias CaminoChallenge.Pessoas.Services.CreatePessoaJuridica

  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    pessoas_juridicas = PessoaJuridicaRepository.list_pessoas_juridicas()
    render(conn, "index.json", pessoas_juridicas: pessoas_juridicas)
  end

  def create(conn, %{"pessoa_juridica" => pessoa_juridica_params}) do
    changeset =
      PessoaJuridicaParams.from(pessoa_juridica_params, with: &PessoaJuridicaParams.child/2)

    if changeset.valid? do
      with {:ok, {pessoa_juridica, endereco}} <-
             CreatePessoaJuridica.execute(pessoa_juridica_params) do
        conn
        |> put_status(:created)
        |> render("create.json", pessoa_juridica: pessoa_juridica, endereco: endereco)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(CaminoChallengeWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end
end
