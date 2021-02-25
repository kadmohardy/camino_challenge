defmodule CaminoChallengeWeb.Api.PessoaJuridicaControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Pessoas.Entities.PessoaJuridica
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository
  alias CaminoChallenge.PessoaJuridicaFixture

  def fixture(:pessoa_juridica) do
    {:ok, pessoa_juridica} =
      PessoaJuridicaRepository.create_pessoa_juridica(
        PessoaJuridicaFixture.valid_pessoa_juridica()
      )

    pessoa_juridica
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pessoas_juridicas", %{conn: conn} do
      conn = get(conn, Routes.api_pessoa_juridica_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pessoa_juridica" do
    test "testing create contrato with valid attrs", %{conn: conn} do
      api_conn =
        conn
        |> post("/api/pessoas/juridicas",
          pessoa_juridica: PessoaJuridicaFixture.valid_pessoa_juridica()
        )

      body = api_conn |> response(201) |> Poison.decode!()

      response = body["data"]

      assert response["cnpj"] == "123456789104321"
      assert response["nome"] == "some nome"

      # cnpj: "123456789104321",
      # nome: "some nome",
      # endereco: %{
      #   cep: "12345450",
      #   cidade: "Sobral",
      #   uf: "CE",
      #   pais: "Brasil",
      #   rua: "Rua Um, 21"
      # }
    end
  end

  defp create_pessoa_juridica(_) do
    pessoa_juridica = fixture(:pessoa_juridica)
    %{pessoa_juridica: pessoa_juridica}
  end
end
