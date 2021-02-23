defmodule CaminoChallengeWeb.Api.ContratoController do
  use CaminoChallengeWeb, :controller

  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, _params) do
    contratos = ContratoRepository.list_contratos()
    render(conn, "index.json", contratos: contratos)
  end

  def create(conn, %{"contrato" => contrato_params}) do
    with {:ok, %Contrato{} = contrato} <- ContratoRepository.create_contrato(contrato_params) do
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

  def update(conn, %{"id" => id, "contrato" => contrato_params}) do
    contrato = ContratoRepository.get_contrato!(id)

    with {:ok, %Contrato{} = contrato} <-
           ContratoRepository.update_contrato(contrato, contrato_params) do
      render(conn, "show.json", contrato: contrato)
    end
  end

  def delete(conn, %{"id" => id}) do
    contrato = ContratoRepository.get_contrato!(id)

    with {:ok, %Contrato{}} <- ContratoRepository.delete_contrato(contrato) do
      send_resp(conn, :no_content, "")
    end
  end
end
