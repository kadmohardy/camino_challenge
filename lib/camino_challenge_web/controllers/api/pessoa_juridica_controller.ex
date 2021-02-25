defmodule CaminoChallengeWeb.Api.PessoaJuridicaController do
  use CaminoChallengeWeb, :controller

  alias CaminoChallenge.Pessoas.Entities.PessoaJuridica
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository
  require Logger
  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    pessoas_juridicas = PessoaJuridicaRepository.list_pessoas_juridicas()
    render(conn, "index.json", pessoas_juridicas: pessoas_juridicas)
  end

  def create(conn, %{"pessoa_juridica" => pessoa_juridica_params}) do
    with {:ok, {pessoa_juridica, endereco}} <-
           PessoaJuridicaRepository.create_pessoa_juridica(pessoa_juridica_params) do
      conn
      |> put_status(:created)
      |> render("create.json", pessoa_juridica: pessoa_juridica, endereco: endereco)
    end
  end

  def show(conn, %{"id" => id}) do
    pessoa_juridica = PessoaJuridicaRepository.get_pessoa_juridica!(id)
    render(conn, "show.json", pessoa_juridica: pessoa_juridica)
  end

  def update(conn, %{"id" => id, "pessoa_juridica" => pessoa_juridica_params}) do
    pessoa_juridica = PessoaJuridicaRepository.get_pessoa_juridica!(id)

    with {:ok, %PessoaJuridica{} = pessoa_juridica} <-
           PessoaJuridicaRepository.update_pessoa_juridica(
             pessoa_juridica,
             pessoa_juridica_params
           ) do
      render(conn, "show.json", pessoa_juridica: pessoa_juridica)
    end
  end

  def delete(conn, %{"id" => id}) do
    pessoa_juridica = PessoaJuridicaRepository.get_pessoa_juridica!(id)

    with {:ok, %PessoaJuridica{}} <-
           PessoaJuridicaRepository.delete_pessoa_juridica(pessoa_juridica) do
      send_resp(conn, :no_content, "")
    end
  end
end
