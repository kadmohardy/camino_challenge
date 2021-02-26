defmodule CaminoChallenge.ContratosTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  describe "contratos" do
    alias CaminoChallenge.Contratos.Entities.Contrato

    @valid_attrs %{
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

    def contrato_fixture(attrs \\ %{}) do
      {:ok, contrato} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contratos.create_contrato()

      contrato
    end

    test "list_contratos/0 returns all contratos" do
      contrato = contrato_fixture()
      assert Contratos.list_contratos() == [contrato]
    end

    test "get_contrato!/1 returns the contrato with given id" do
      contrato = contrato_fixture()
      assert Contratos.get_contrato!(contrato.id) == contrato
    end

    test "create_contrato/1 with valid data creates a contrato" do
      assert {:ok, %Contrato{} = contrato} = Contratos.create_contrato(@valid_attrs)
      assert contrato.data == ~D[2010-04-17]
      assert contrato.descricao == "some descricao"
      assert contrato.file == "some file"
      assert contrato.lista_partes == "some lista_partes"
      assert contrato.nome == "some nome"
    end

    test "create_contrato/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contratos.create_contrato(@invalid_attrs)
    end

    test "update_contrato/2 with valid data updates the contrato" do
      contrato = contrato_fixture()
      assert {:ok, %Contrato{} = contrato} = Contratos.update_contrato(contrato, @update_attrs)
      assert contrato.data == ~D[2011-05-18]
      assert contrato.descricao == "some updated descricao"
      assert contrato.file == "some updated file"
      assert contrato.lista_partes == "some updated lista_partes"
      assert contrato.nome == "some updated nome"
    end

    test "update_contrato/2 with invalid data returns error changeset" do
      contrato = contrato_fixture()
      assert {:error, %Ecto.Changeset{}} = Contratos.update_contrato(contrato, @invalid_attrs)
      assert contrato == Contratos.get_contrato!(contrato.id)
    end

    test "delete_contrato/1 deletes the contrato" do
      contrato = contrato_fixture()
      assert {:ok, %Contrato{}} = Contratos.delete_contrato(contrato)
      assert_raise Ecto.NoResultsError, fn -> Contratos.get_contrato!(contrato.id) end
    end

    test "change_contrato/1 returns a contrato changeset" do
      contrato = contrato_fixture()
      assert %Ecto.Changeset{} = Contratos.change_contrato(contrato)
    end
  end
end
