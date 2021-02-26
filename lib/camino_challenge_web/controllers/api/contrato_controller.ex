defmodule CaminoChallengeWeb.Api.ContratoController do
  use CaminoChallengeWeb, :controller

  alias CaminoChallenge.Api.Params.ContratoParams
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  require Logger
  action_fallback CaminoChallengeWeb.FallbackController

  def index(conn, params) do
    with {:ok, contratos} <- ContratoRepository.list_contratos(params) do
      conn
      |> render("index.json", contratos: contratos)
    end
  end

  def create(conn, params) do
    changeset = ContratoParams.from(params, with: &ContratoParams.child/2)

    if changeset.valid? do
      with {:ok, {contrato, _arquivo}} <- ContratoRepository.create_contrato(params) do
        conn
        |> put_status(:created)
        |> render("show.json", contrato: contrato)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(CaminoChallengeWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end
end
