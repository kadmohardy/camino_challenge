defmodule CaminoChallengeWeb.Api.PessoaFisicaControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Fixtures.PessoaFisicaFixture
  alias CaminoChallenge.PessoasFisicas.Repositories.PessoaFisicaRepository

  def fixture(:pessoa_fisica) do
    {:ok, pessoa_fisica} =
      PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica())

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
    test "testing create pessoa fisica with valid attrs", %{conn: conn} do
      api_conn =
        conn
        |> post("/api/pessoas/fisicas", pessoa_fisica: PessoaFisicaFixture.valid_pessoa_fisica())

      body = api_conn |> response(201) |> Poison.decode!()

      response = body["data"]

      assert response["cpf"] == "65330503035"
      assert response["nome"] == "some nome"
      assert response["data_nascimento"] == "2010-04-17"
      assert response["tipo"] == "fisica"
    end

    test "testing create pessoa fisica with invalid attrs", %{conn: conn} do
      api_conn =
        conn
        |> post("/api/pessoas/fisicas", pessoa_fisica: PessoaFisicaFixture.invalid_pessoa_fisica())

      body = api_conn |> response(422) |> Poison.decode!()

      response = body["errors"]

      assert response["data_nascimento"] == ["is invalid"]
    end
  end

  defp create_pessoa_fisica(_) do
    pessoa_fisica = fixture(:pessoa_fisica)
    %{pessoa_fisica: pessoa_fisica}
  end
end
