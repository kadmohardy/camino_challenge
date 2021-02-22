defmodule CaminoChallenge.PessoasFisicas.Repositories.PessoasFisicasTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.PessoasFisicas.Repositories.PessoaFisicaRepository

  describe "pessoas_fisicas" do
    alias CaminoChallenge.PessoasFisicas.Entities.PessoaFisica

    @valid_attrs %{cpf: "some cpf", data_nascimento: ~D[2010-04-17], nome: "some nome"}
    @update_attrs %{
      cpf: "some updated cpf",
      data_nascimento: ~D[2011-05-18],
      nome: "some updated nome"
    }
    @invalid_attrs %{cpf: nil, data_nascimento: nil, nome: nil}

    def pessoa_fisica_fixture(attrs \\ %{}) do
      {:ok, pessoa_fisica} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PessoaFisicaRepository.create_pessoa_fisica()

      pessoa_fisica
    end

    test "list_pessoas_fisicas/0 returns all pessoas_fisicas" do
      pessoa_fisica = pessoa_fisica_fixture()
      assert PessoaFisicaRepository.list_pessoas_fisicas() == [pessoa_fisica]
    end

    test "get_pessoa_fisica!/1 returns the pessoa_fisica with given id" do
      pessoa_fisica = pessoa_fisica_fixture()
      assert PessoaFisicaRepository.get_pessoa_fisica!(pessoa_fisica.id) == pessoa_fisica
    end

    test "create_pessoa_fisica/1 with valid data creates a pessoa_fisica" do
      assert {:ok, %PessoaFisica{} = pessoa_fisica} =
               PessoaFisicaRepository.create_pessoa_fisica(@valid_attrs)

      assert pessoa_fisica.cpf == "some cpf"
      assert pessoa_fisica.data_nascimento == ~D[2010-04-17]
      assert pessoa_fisica.nome == "some nome"
    end

    test "create_pessoa_fisica/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               PessoaFisicaRepository.create_pessoa_fisica(@invalid_attrs)
    end

    test "update_pessoa_fisica/2 with valid data updates the pessoa_fisica" do
      pessoa_fisica = pessoa_fisica_fixture()

      assert {:ok, %PessoaFisica{} = pessoa_fisica} =
               PessoaFisicaRepository.update_pessoa_fisica(pessoa_fisica, @update_attrs)

      assert pessoa_fisica.cpf == "some updated cpf"
      assert pessoa_fisica.data_nascimento == ~D[2011-05-18]
      assert pessoa_fisica.nome == "some updated nome"
    end

    test "update_pessoa_fisica/2 with invalid data returns error changeset" do
      pessoa_fisica = pessoa_fisica_fixture()

      assert {:error, %Ecto.Changeset{}} =
               PessoaFisicaRepository.update_pessoa_fisica(pessoa_fisica, @invalid_attrs)

      assert pessoa_fisica == PessoaFisicaRepository.get_pessoa_fisica!(pessoa_fisica.id)
    end

    test "delete_pessoa_fisica/1 deletes the pessoa_fisica" do
      pessoa_fisica = pessoa_fisica_fixture()
      assert {:ok, %PessoaFisica{}} = PessoaFisicaRepository.delete_pessoa_fisica(pessoa_fisica)

      assert_raise Ecto.NoResultsError, fn ->
        PessoaFisicaRepository.get_pessoa_fisica!(pessoa_fisica.id)
      end
    end

    test "change_pessoa_fisica/1 returns a pessoa_fisica changeset" do
      pessoa_fisica = pessoa_fisica_fixture()
      assert %Ecto.Changeset{} = PessoaFisicaRepository.change_pessoa_fisica(pessoa_fisica)
    end
  end
end
