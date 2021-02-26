defmodule CaminoChallenge.ContratosTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.Contratos.Repositories.ContratoRepository
  alias CaminoChallenge.Fixtures.ContratoFixture
  require Logger

  describe "contratos" do
    alias CaminoChallenge.Contratos.Entities.Contrato

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

    @invalid_attrs %{}

    def contrato_fixture(attrs \\ %{}) do
      {:ok, contrato} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContratoRepository.create_contrato()

      contrato
    end

    test "list_contratos/0 returns all contratos" do
      contrato = contrato_fixture()
      assert ContratoRepository.list_contratos() == [contrato]
    end
  end
end
