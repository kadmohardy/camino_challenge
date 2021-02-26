defmodule CaminoChallenge.PessoasJuridicas.Repositories.PessoasJuridicasTest do
  use CaminoChallenge.DataCase

  alias CaminoChallenge.Fixtures.PessoaJuridicaFixture

  describe "pessoas_juridicas" do
    alias CaminoChallenge.Pessoas.Entities.PessoaJuridica
    alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository

    def pessoa_juridica_fixture(attrs \\ %{}) do
      {:ok, pessoa_juridica} =
        attrs
        |> Enum.into(PessoaJuridicaFixture.valid_pessoa_juridica())
        |> PessoaJuridicaRepository.create_pessoa_juridica()

      pessoa_juridica
    end

    test "list_pessoas_juridicas/0 returns all pessoas_juridicas" do
      pessoa_juridica = pessoa_juridica_fixture()
      assert PessoaJuridicaRepository.list_pessoas_juridicas() |> Enum.count() == 1
    end

    test "create_pessoa_juridica/1 with valid data creates a pessoa_juridica" do
      {:ok, {%PessoaJuridica{} = pessoa_juridica, _}} =
        PessoaJuridicaRepository.create_pessoa_juridica(
          PessoaJuridicaFixture.valid_pessoa_juridica()
        )

      assert pessoa_juridica.cnpj == "123456789104321"
      assert pessoa_juridica.pessoa.nome == "some nome"
    end

    test "create_pessoa_juridica/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               PessoaJuridicaRepository.create_pessoa_juridica(
                 PessoaJuridicaFixture.invalid_pessoa_juridica()
               )
    end
  end
end
