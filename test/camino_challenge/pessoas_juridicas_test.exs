defmodule CaminoChallenge.PessoasJuridicasTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.PessoasJuridicas

  describe "adresses" do
    alias CaminoChallenge.PessoasJuridicas.Adress

    @valid_attrs %{
      cep: "some cep",
      cidade: "some cidade",
      pais: "some pais",
      rua: "some rua",
      uf: "some uf"
    }
    @update_attrs %{
      cep: "some updated cep",
      cidade: "some updated cidade",
      pais: "some updated pais",
      rua: "some updated rua",
      uf: "some updated uf"
    }
    @invalid_attrs %{cep: nil, cidade: nil, pais: nil, rua: nil, uf: nil}

    def adress_fixture(attrs \\ %{}) do
      {:ok, adress} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PessoasJuridicas.create_adress()

      adress
    end

    test "list_adresses/0 returns all adresses" do
      adress = adress_fixture()
      assert PessoasJuridicas.list_adresses() == [adress]
    end

    test "get_adress!/1 returns the adress with given id" do
      adress = adress_fixture()
      assert PessoasJuridicas.get_adress!(adress.id) == adress
    end

    test "create_adress/1 with valid data creates a adress" do
      assert {:ok, %Adress{} = adress} = PessoasJuridicas.create_adress(@valid_attrs)
      assert adress.cep == "some cep"
      assert adress.cidade == "some cidade"
      assert adress.pais == "some pais"
      assert adress.rua == "some rua"
      assert adress.uf == "some uf"
    end

    test "create_adress/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PessoasJuridicas.create_adress(@invalid_attrs)
    end

    test "update_adress/2 with valid data updates the adress" do
      adress = adress_fixture()
      assert {:ok, %Adress{} = adress} = PessoasJuridicas.update_adress(adress, @update_attrs)
      assert adress.cep == "some updated cep"
      assert adress.cidade == "some updated cidade"
      assert adress.pais == "some updated pais"
      assert adress.rua == "some updated rua"
      assert adress.uf == "some updated uf"
    end

    test "update_adress/2 with invalid data returns error changeset" do
      adress = adress_fixture()
      assert {:error, %Ecto.Changeset{}} = PessoasJuridicas.update_adress(adress, @invalid_attrs)
      assert adress == PessoasJuridicas.get_adress!(adress.id)
    end

    test "delete_adress/1 deletes the adress" do
      adress = adress_fixture()
      assert {:ok, %Adress{}} = PessoasJuridicas.delete_adress(adress)
      assert_raise Ecto.NoResultsError, fn -> PessoasJuridicas.get_adress!(adress.id) end
    end

    test "change_adress/1 returns a adress changeset" do
      adress = adress_fixture()
      assert %Ecto.Changeset{} = PessoasJuridicas.change_adress(adress)
    end
  end
end
