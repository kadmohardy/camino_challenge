defmodule CaminoChallenge.PessoasJuridicas.Repositories.PessoasJuridicasTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.PessoasJuridicas.Repositories.PessoaJuridicaRepository

  describe "pessoas_juridicas" do
    alias CaminoChallenge.PessoasJuridicas.Entities.PessoaJuridica

    @valid_attrs %{cnpj: "some cnpj", endereco: "some endereco", nome: "some nome"}
    @update_attrs %{
      cnpj: "some updated cnpj",
      endereco: "some updated endereco",
      nome: "some updated nome"
    }
    @invalid_attrs %{cnpj: nil, endereco: nil, nome: nil}

    def pessoa_juridica_fixture(attrs \\ %{}) do
      {:ok, pessoa_juridica} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PessoaJuridicaRepository.create_pessoa_juridica()

      pessoa_juridica
    end

    test "list_pessoas_juridicas/0 returns all pessoas_juridicas" do
      pessoa_juridica = pessoa_juridica_fixture()
      assert PessoaJuridicaRepository.list_pessoas_juridicas() == [pessoa_juridica]
    end

    test "get_pessoa_juridica!/1 returns the pessoa_juridica with given id" do
      pessoa_juridica = pessoa_juridica_fixture()
      assert PessoaJuridicaRepository.get_pessoa_juridica!(pessoa_juridica.id) == pessoa_juridica
    end

    test "create_pessoa_juridica/1 with valid data creates a pessoa_juridica" do
      assert {:ok, %PessoaJuridica{} = pessoa_juridica} =
               PessoaJuridicaRepository.create_pessoa_juridica(@valid_attrs)

      assert pessoa_juridica.cnpj == "some cnpj"
      assert pessoa_juridica.endereco == "some endereco"
      assert pessoa_juridica.nome == "some nome"
    end

    test "create_pessoa_juridica/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               PessoaJuridicaRepository.create_pessoa_juridica(@invalid_attrs)
    end

    test "update_pessoa_juridica/2 with valid data updates the pessoa_juridica" do
      pessoa_juridica = pessoa_juridica_fixture()

      assert {:ok, %PessoaJuridica{} = pessoa_juridica} =
               PessoaJuridicaRepository.update_pessoa_juridica(pessoa_juridica, @update_attrs)

      assert pessoa_juridica.cnpj == "some updated cnpj"
      assert pessoa_juridica.endereco == "some updated endereco"
      assert pessoa_juridica.nome == "some updated nome"
    end

    test "update_pessoa_juridica/2 with invalid data returns error changeset" do
      pessoa_juridica = pessoa_juridica_fixture()

      assert {:error, %Ecto.Changeset{}} =
               PessoaJuridicaRepository.update_pessoa_juridica(pessoa_juridica, @invalid_attrs)

      assert pessoa_juridica == PessoaJuridicaRepository.get_pessoa_juridica!(pessoa_juridica.id)
    end

    test "delete_pessoa_juridica/1 deletes the pessoa_juridica" do
      pessoa_juridica = pessoa_juridica_fixture()

      assert {:ok, %PessoaJuridica{}} =
               PessoaJuridicaRepository.delete_pessoa_juridica(pessoa_juridica)

      assert_raise Ecto.NoResultsError, fn ->
        PessoaJuridicaRepository.get_pessoa_juridica!(pessoa_juridica.id)
      end
    end

    test "change_pessoa_juridica/1 returns a pessoa_juridica changeset" do
      pessoa_juridica = pessoa_juridica_fixture()
      assert %Ecto.Changeset{} = PessoaJuridicaRepository.change_pessoa_juridica(pessoa_juridica)
    end
  end
end
