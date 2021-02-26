defmodule CaminoChallengeWeb.ContratoControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Services.ListContratos
  alias CaminoChallenge.Fixtures.PessoaFisicaFixture
  alias CaminoChallenge.Fixtures.PessoaJuridicaFixture

  @create_attrs %{
    data: ~D[2010-04-17],
    descricao: "some descricao",
    file: "some file",
    lista_partes: "some lista_partes",
    nome: "some nome"
  }

  def fixture(:contrato) do
    {:ok, pessoa_fisica} = CreateContrato.execute(PessoaFisicaFixture.valid_pessoa_fisica())
    {:ok, pessoa_juridica} = CreateContrato.execute(PessoaJuridicaFixture.valid_pessoa_juridica())

    {:ok, contrato} = CreateContrato.execute(@create_attrs)

    {:ok, contrato} = CreateContrato.execute(@create_attrs)
    contrato
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contratos", %{conn: conn} do
      conn = get(conn, Routes.api_contrato_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contrato" do
    test "testing create contrato with valid attrs", %{conn: conn} do
    end
  end

  defp create_contrato(_) do
    contrato = fixture(:contrato)
    %{contrato: contrato}
  end
end
