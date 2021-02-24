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
  Gets a single pessoa_fisica.

  Raises `Ecto.NoResultsError` if the Pessoa fisica does not exist.

  ## Examples

      iex> get_pessoa_fisica!(123)
      %PessoaFisica{}

      iex> get_pessoa_fisica!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pessoa_fisica!(id), do: Repo.get!(PessoaFisica, id)

  @doc """
  Creates a pessoa_fisica.

  ## Examples

      iex> create_pessoa_fisica(%{field: value})
      {:ok, %PessoaFisica{}}

      iex> create_pessoa_fisica(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_pessoa_fisica(attrs \\ %{}) do
  #   %PessoaFisica{}
  #   |> PessoaFisica.changeset(attrs)
  #   |> Repo.insert()
  # end
  # %{"nome" => nome, "cpf" => cpf, "data_nascimento" => data_nascimento}
  def create_pessoa_fisica(attrs \\ %{}) do
    nome = attrs["nome"] || attrs.nome
    cpf = attrs["cpf"] || attrs.cpf
    data_nascimento = attrs["data_nascimento"] || attrs.data_nascimento

    Repo.get_by(PessoaFisica, cpf: cpf)
    |> case do
      nil ->
        Repo.transaction(fn ->
          {:ok, pessoa} = Repo.insert(%Pessoa{nome: nome, type: "fisica"})

          {:ok, pessoa_juridica} =
            %PessoaFisica{}
            |> PessoaFisica.changeset(%{
              cpf: cpf,
              data_nascimento: data_nascimento
            })
            |> Ecto.Changeset.put_assoc(:pessoa, pessoa)
            |> Repo.insert()

          pessoa_juridica
        end)

      _ ->
        {:error, "Já existe um cadastro para este CPF."}
    end
  end
end
