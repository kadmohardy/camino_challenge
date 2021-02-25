defmodule CaminoChallengeWeb.ContratoControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Contratos.Services.ListContratos
  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Fixtures.PessoaFisicaFixture
  alias CaminoChallenge.Fixtures.PessoaJuridicaFixture

  @create_attrs %{
    data: ~D[2010-04-17],
    descricao: "some descricao",
    file: "some file",
    lista_partes: "some lista_partes",
    nome: "some nome"
  }
  @update_attrs %{
    data: ~D[2011-05-18],
    descricao: "some updated descricao",
    file: "some updated file",
    lista_partes: "some updated lista_partes",
    nome: "some updated nome"
  }
  @invalid_attrs %{data: nil, descricao: nil, file: nil, lista_partes: nil, nome: nil}

  def fixture(:contrato) do
    {:ok, contrato} = CreateContrato.execute(PessoaFisicaFixture)
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

  describe "create contrato" do
    # test "renders contrato when data is valid", %{conn: conn} do
    #   conn = post(conn, Routes.api_contrato_path(conn, :create), contrato: @create_attrs)
    #   assert %{"id" => id} = json_response(conn, 201)["data"]

    #   assert %{
    #            "id" => id,
    #            "data" => "2010-04-17",
    #            "descricao" => "some descricao"
    #          } = json_response(conn, 200)["data"]
    # end

    # test "renders errors when data is invalid", %{conn: conn} do
    #   conn = post(conn, Routes.api_contrato_path(conn, :create), contrato: @invalid_attrs)
    #   assert json_response(conn, 422)["errors"] != %{}
    # end
  end

  defp create_contrato(_) do
    contrato = fixture(:contrato)
    %{contrato: contrato}
  end
end
