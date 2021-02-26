defmodule CaminoChallenge.Pessoas.Repositories.PessoasFisicasTest do
  use CaminoChallenge.DataCase
  require Logger
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository

  describe "pessoas_fisicas" do
    alias CaminoChallenge.Fixtures.PessoaFisicaFixture
    alias CaminoChallenge.Pessoas.Entities.PessoaFisica

    def pessoa_fisica_fixture(attrs \\ %{}) do
      {:ok, pessoa_fisica} =
        attrs
        |> Enum.into(PessoaFisicaFixture.valid_pessoa_fisica())
        |> PessoaFisicaRepository.create_pessoa_fisica()

      pessoa_fisica
    end

    test "list_pessoas_fisicas/0 returns all pessoas_fisicas" do
      pessoa_fisica = pessoa_fisica_fixture()
      assert PessoaFisicaRepository.list_pessoas_fisicas() |> Enum.count() == 1
    end

    test "create_pessoa_fisica/1 with valid data creates a pessoa_fisica" do
      assert {:ok, %PessoaFisica{} = pessoa_fisica} =
               PessoaFisicaRepository.create_pessoa_fisica(
                 PessoaFisicaFixture.valid_pessoa_fisica()
               )

      assert pessoa_fisica.cpf == "65330503035"
      assert pessoa_fisica.data_nascimento == ~D[2010-04-17]
      assert pessoa_fisica.pessoa.nome == "some nome"
      assert pessoa_fisica.pessoa.type == "fisica"
    end

    test "create_pessoa_fisica/1 with invalid data returns error changeset" do
      {:error, %Ecto.Changeset{}, errors, data} =
               PessoaFisicaRepository.create_pessoa_fisica(
                 PessoaFisicaFixture.invalid_pessoa_fisica()
               )

    end
  end
end
