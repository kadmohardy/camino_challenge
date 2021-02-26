defmodule CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository do
  @moduledoc """
  The PessoasFisicas context.
  """

  import Ecto.Query, warn: false
  alias CaminoChallenge.Repo
  require Logger
  alias CaminoChallenge.Pessoas.Entities.Pessoa
  alias CaminoChallenge.Pessoas.Entities.PessoaFisica

  @doc """
  Returns the list of pessoas_fisicas.

  ## Examples

      iex> list_pessoas_fisicas()
      [%PessoaFisica{}, ...]

  """
  def list_pessoas_fisicas do
    Repo.all(PessoaFisica) |> Repo.preload(:pessoa)
  end

  @doc """
  Creates a pessoa_fisica.

  ## Examples

      iex> create_pessoa_fisica(%{field: value})
      {:ok, %PessoaFisica{}}

      iex> create_pessoa_fisica(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_pessoa_fisica(attrs \\ %{}) do
    nome = attrs["nome"] || attrs.nome
    cpf = attrs["cpf"] || attrs.cpf
    data_nascimento = attrs["data_nascimento"] || attrs.data_nascimento

    Repo.get_by(PessoaFisica, cpf: cpf)
    |> case do
      nil -> transaction_pessoa_fisica(nome, cpf, data_nascimento)
      _ ->
        {:error, "Já existe um cadastro para este CPF."}
    end
  end

  def transaction_pessoa_fisica(nome, cpf, data_nascimento) do
    Repo.transaction(fn ->
      pessoa =
        case Repo.insert(%Pessoa{nome: nome, type: "fisica"}) do
          {:ok, pessoa} -> pessoa
          {:error, changeset} -> Repo.rollback(changeset)
        end

      try_insert_pessoa_fisica(cpf, data_nascimento, pessoa)
    end)
  end

  def try_insert_pessoa_fisica(cpf, data_nascimento, pessoa) do
    case %PessoaFisica{}
          |> PessoaFisica.changeset(%{
            cpf: cpf,
            data_nascimento: data_nascimento
          })
          |> Ecto.Changeset.put_assoc(:pessoa, pessoa)
          |> Repo.insert() do
      {:ok, pessoa_fisica} -> pessoa_fisica
      {:error, changeset} -> Repo.rollback(changeset)
    end
  end
end
