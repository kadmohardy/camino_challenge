defmodule CaminoChallengeWeb.ContratoControllerTest do
  use CaminoChallengeWeb.ConnCase

  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Services.ListContratos
  alias CaminoChallenge.Fixtures.PessoaFisicaFixture
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository

  def fixture(:contrato) do
    {:ok, pessoa_fisica} =
          PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica())

    {:ok, contrato} = CreateContrato.execute(%{
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

    contrato
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contratos", %{conn: conn} do
    {:ok, pessoa_fisica} =
      PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica())
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

      conn_index = get(conn, Routes.api_contrato_path(conn, :index))
      assert json_response(conn_index, 200)["data"] |> Enum.count() == 1

    end
  end

  describe "create contrato" do
    test "testing create contrato with valid attrs", %{conn: conn} do
    {:ok, pessoa_fisica} =
      PessoaFisicaRepository.create_pessoa_fisica(PessoaFisicaFixture.valid_pessoa_fisica())

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
  end

  defp create_contrato(_) do
    contrato = fixture(:contrato)
    %{contrato: contrato}
  end
end
