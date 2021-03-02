defmodule CaminoChallengeWeb.ContratoControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Contratos.Repositories.ContratoRepository
  alias CaminoChallenge.Fixtures.PessoaFisicaFixture
  alias CaminoChallenge.Fixtures.PessoaJuridicaFixture

  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository

  def fixture(:contrato) do
    {:ok, pessoa_fisica} =
      PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica())

    ContratoRepository.create_contrato(%{
      nome: "some name",
      descricao: "some description",
      data: "2020-09-24",
      arquivo: %Plug.Upload{
        path: "test/support/fixtures/files/desafio.pdf",
        content_type: "application/pdf",
        filename: "desafio.pdf"
      },
      partes: pessoa_fisica.pessoa_id
    })

    ContratoRepository.create_contrato(%{
      nome: "some name 2",
      descricao: "some description 2",
      data: "2020-09-25",
      arquivo: %Plug.Upload{
        path: "test/support/fixtures/files/desafio.pdf",
        content_type: "application/pdf",
        filename: "desafio.pdf"
      },
      partes: pessoa_fisica.pessoa_id
    })

    pessoa_fisica
  end

  setup %{conn: conn} do
    fixture(:contrato)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "test contratos" do
    test "lists all contratos", %{conn: conn} do
      api_conn =
        conn
        |> get("/api/contratos")

      body = api_conn |> response(200) |> Poison.decode!()
      item = body["data"] |> Enum.at(0)
      assert body["data"] |> Enum.count() == 2

      assert item["data"] == "2020-09-24"
      assert item["descricao"] == "some description"
      assert item["nome"] == "some name"
    end

    test "listando contratos por filtro de data", %{conn: conn} do
      api_conn =
        conn
        |> get("/api/contratos", %{data: "2020-09-24"})

      body = api_conn |> response(200) |> Poison.decode!()
      assert body["data"] |> Enum.count() == 1
    end

    test "listando contratos por filtro de pessoa_id", %{conn: conn} do
      api_conn =
        conn
        |> get("/api/contratos", %{pessoa_id: "95827e2e-3457-471e-8a61-92a1cf6c4cfa"})

      body = api_conn |> response(200) |> Poison.decode!()
      assert body["data"] |> Enum.count() == 0
    end

    test "listando contratos por filtro", %{conn: conn} do
      api_conn =
        conn
        |> get("/api/contratos", %{
          data: "2020-09-24",
          pessoa_id: "95827e2e-3457-471e-8a61-92a1cf6c4cfa"
        })

      body = api_conn |> response(200) |> Poison.decode!()
      assert body["data"] |> Enum.count() == 0
    end

    test "testing create contrato with valid attrs", %{conn: conn} do
      {:ok, pessoa_fisica} =
        PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica_2())

      {:ok, pessoa_juridica} =
        PessoaJuridicaRepository.create_pessoa_juridica(
          PessoaJuridicaFixture.valid_pessoa_juridica_2()
        )

      api_conn =
        conn
        |> post("/api/contratos", %{
          nome: "some name",
          descricao: "some description",
          data: "2020-09-24",
          arquivo: %Plug.Upload{
            path: "test/support/fixtures/files/desafio.pdf",
            content_type: "application/pdf",
            filename: "desafio.pdf"
          },
          partes: pessoa_fisica.pessoa_id
        })

      body = api_conn |> response(201) |> Poison.decode!()

      response = body["data"]

      assert response["data"] == "2020-09-24"
      assert response["descricao"] == "some description"
      assert response["nome"] == "some name"
    end

    test "testing create contrato with invalid attrs", %{conn: conn} do
      {:ok, pessoa_fisica} =
        PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica_2())

      api_conn =
        conn
        |> post("/api/contratos", %{})

      body = api_conn |> response(422) |> Poison.decode!()

      response = body["errors"]

      assert response["arquivo"] == ["can't be blank"]
      assert response["data"] == ["can't be blank"]
      assert response["nome"] == ["can't be blank"]
      assert response["descricao"] == ["can't be blank"]
      assert response["partes"] == ["A lista não corresponde a UUIDs validos", "can't be blank"]
    end

    test "testing create contrato with invalid partes", %{conn: conn} do
      api_conn =
        conn
        |> post("/api/contratos", %{
          nome: "some name",
          descricao: "some description",
          data: "2020-09-24",
          arquivo: %Plug.Upload{
            path: "test/support/fixtures/files/desafio.pdf",
            content_type: "application/pdf",
            filename: "desafio.pdf"
          },
          partes: nil
        })

      body = api_conn |> response(422) |> Poison.decode!()

      response = body["errors"]
      assert response["partes"] == ["A lista não corresponde a UUIDs validos", "can't be blank"]
    end
  end
end
