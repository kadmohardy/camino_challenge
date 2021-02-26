defmodule CaminoChallenge.ContratosTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  alias CaminoChallenge.Pessoas.Entities.Pessoa

  require Logger

  @pessoa_valid %{
    nome: "some nome",
    type: "fisica"
  }

  describe "contratos" do
    @valid_attrs %{
      nome: "some name",
      descricao: "some description",
      data: "2020-09-24",
      arquivo: %Plug.Upload{
        path: "test/support/fixtures/files/desafio.pdf",
        content_type: "application/pdf",
        filename: "desafio.pdf"
      },
      partes: "a326ccad-9ae1-4fc6-940c-690661e37403,3311ee36-7057-4cfe-b803-0a5686d76668"
    }

    def contrato_fixture(attrs \\ %{}) do
      {:ok, contrato} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContratoRepository.create_contrato()

      contrato
    end

    def pessoa_fixture do
      {:ok, pessoa} =
        %Pessoa{}
        |> Pessoa.changeset(@pessoa_valid)
        |> Repo.insert()

      pessoa
    end

    test "list_contratos/0 returns all contratos" do
      pessoa = pessoa_fixture()

      ContratoRepository.create_contrato(%{
        nome: "some name",
        descricao: "some description",
        data: "2020-09-24",
        arquivo: %Plug.Upload{
          path: "test/support/fixtures/files/desafio.pdf",
          content_type: "application/pdf",
          filename: "desafio.pdf"
        },
        partes: pessoa.id
      })

      {:ok, contrato} = ContratoRepository.list_contratos(%{})
      assert contrato |> Enum.count() == 1
    end
  end
end
