defmodule CaminoChallengeWeb.ContratoControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Contratos
  alias CaminoChallenge.Contratos.Contrato

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
    {:ok, contrato} = Contratos.create_contrato(@create_attrs)
    contrato
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contratos", %{conn: conn} do
      conn = get(conn, Routes.contrato_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contrato" do
    test "renders contrato when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contrato_path(conn, :create), contrato: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.contrato_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => "2010-04-17",
               "descricao" => "some descricao",
               "file" => "some file",
               "lista_partes" => "some lista_partes",
               "nome" => "some nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contrato_path(conn, :create), contrato: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contrato" do
    setup [:create_contrato]

    test "renders contrato when data is valid", %{
      conn: conn,
      contrato: %Contrato{id: id} = contrato
    } do
      conn = put(conn, Routes.contrato_path(conn, :update, contrato), contrato: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.contrato_path(conn, :show, id))

      assert %{
               "id" => id,
               "data" => "2011-05-18",
               "descricao" => "some updated descricao",
               "file" => "some updated file",
               "lista_partes" => "some updated lista_partes",
               "nome" => "some updated nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, contrato: contrato} do
      conn = put(conn, Routes.contrato_path(conn, :update, contrato), contrato: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contrato" do
    setup [:create_contrato]

    test "deletes chosen contrato", %{conn: conn, contrato: contrato} do
      conn = delete(conn, Routes.contrato_path(conn, :delete, contrato))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.contrato_path(conn, :show, contrato))
      end
    end
  end

  defp create_contrato(_) do
    contrato = fixture(:contrato)
    %{contrato: contrato}
  end
end
