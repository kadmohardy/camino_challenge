defmodule CaminoChallengeWeb.Api.PessoaJuridicaController do
  use CaminoChallengeWeb, :controller

  alias CaminoChallenge.Pessoas.Entities.PessoaJuridica
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository
  alias CaminoChallenge.Pessoas.Services.CreatePessoaJuridica

  require Logger
  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    pessoas_juridicas = PessoaJuridicaRepository.list_pessoas_juridicas()
    render(conn, "index.json", pessoas_juridicas: pessoas_juridicas)
  end

  def create(conn, %{"pessoa_juridica" => pessoa_juridica_params}) do
    with {:ok, {pessoa_juridica, endereco}} <-
           CreatePessoaJuridica.create_pessoa_juridica(pessoa_juridica_params) do
      conn
      |> put_status(:created)
      |> render("create.json", pessoa_juridica: pessoa_juridica, endereco: endereco)
    end
  end
end
