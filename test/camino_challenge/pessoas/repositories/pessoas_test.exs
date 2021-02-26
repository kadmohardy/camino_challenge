defmodule CaminoChallenge.Pessoas.Repositories.PessoasTest do
  use CaminoChallenge.DataCase
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository
  require Logger

  @pessoa_valid %{
    nome: "some nome",
    type: "fisica"
  }

  @pessoa_invalid %{
    nome: "some nome",
    type: "nao-definido"
  }

  describe "pessoas" do
    alias CaminoChallenge.Pessoas.Entities.Pessoa

    test "create pessoa valid data" do
      {:ok, pessoa} =
        %Pessoa{}
        |> Pessoa.changeset(@pessoa_valid)
        |> Repo.insert()

      assert pessoa.nome == "some nome"
      assert pessoa.type == "fisica"
    end

    test "create pessoa invalid data" do
      {:error, changeset} =
        %Pessoa{}
        |> Pessoa.changeset(@pessoa_invalid)
        |> Repo.insert()

      assert changeset.errors[:type] ==
               {"is invalid", [validation: :inclusion, enum: ["fisica", "juridica"]]}
    end
  end
end
