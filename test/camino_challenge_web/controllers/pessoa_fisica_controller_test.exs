defmodule CaminoChallengeWeb.Api.PessoaFisicaControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.PessoasFisicas.Entities.PessoaFisica
  alias CaminoChallenge.PessoasFisicas.Repositories.PessoaFisicaRepository

  def fixture(:pessoa_fisica) do
    {:ok, pessoa_fisica} = PessoaFisicaRepository.create_pessoa_fisica(@create_attrs)
    pessoa_fisica
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pessoas_fisicas", %{conn: conn} do
      conn = get(conn, Routes.api_pessoa_fisica_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pessoa_fisica" do
    test "renders pessoa_fisica when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.api_pessoa_fisica_path(conn, :create), pessoa_fisica: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_pessoa_fisica_path(conn, :show, id))

      assert %{
               "id" => id,
               "cpf" => "some cpf",
               "data_nascimento" => "2010-04-17",
               "nome" => "some nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.api_pessoa_fisica_path(conn, :create), pessoa_fisica: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_pessoa_fisica(_) do
    pessoa_fisica = fixture(:pessoa_fisica)
    %{pessoa_fisica: pessoa_fisica}
  end
end
