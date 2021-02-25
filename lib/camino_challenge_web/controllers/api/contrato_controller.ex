defmodule CaminoChallengeWeb.Api.ContratoController do
  use CaminoChallengeWeb, :controller

  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Entities.Upload
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository
  alias CaminoChallenge.Contratos.Services.CreateContrato
  require Logger
  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    contratos = ContratoRepository.list_contratos()
    Logger.info(contratos)
    render(conn, "index.json", contratos: contratos)
  end

  def create(conn, params) do
    with {:ok, {contrato, _arquivo}} <- CreateContrato.execute(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_contrato_path(conn, :show, contrato))
      |> render("show.json", contrato: contrato)
    end
  end

  def show(conn, %{"id" => id}) do
    contrato = ContratoRepository.get_contrato!(id)
    render(conn, "show.json", contrato: contrato)
  end
end
