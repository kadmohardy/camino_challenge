defmodule CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository do
  @moduledoc """
  The PessoasJuridicas context.
  """
  require Logger
  import Ecto.Query, warn: false
  alias CaminoChallenge.Pessoas.Entities.Endereco
  alias CaminoChallenge.Pessoas.Entities.Pessoa
  alias CaminoChallenge.Pessoas.Entities.PessoaJuridica
  alias CaminoChallenge.Repo

  @doc """
  Returns the list of pessoas_juridicas.

  ## Examples

      iex> list_pessoas_juridicas()
      [%PessoaJuridica{}, ...]

  """
  def list_pessoas_juridicas do
    Repo.all(PessoaJuridica) |> Repo.preload([:pessoa, :enderecos])
  end

  @doc """
  Gets a single pessoa_juridica.

  Raises `Ecto.NoResultsError` if the Pessoa juridica does not exist.

  ## Examples

      iex> get_pessoa_juridica!(123)
      %PessoaJuridica{}

      iex> get_pessoa_juridica!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pessoa_juridica!(id), do: Repo.get!(PessoaJuridica, id)

  @doc """
  Creates a pessoa_juridica.

  ## Examples

      iex> create_pessoa_juridica(%{field: value})
      {:ok, %PessoaJuridica{}}

      iex> create_pessoa_juridica(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pessoa_juridica(attrs \\ %{}) do
    nome = attrs["nome"] || attrs.nome
    cnpj = attrs["cnpj"] || attrs.cnpj
    endereco = attrs["endereco"] || attrs.endereco

    Repo.get_by(PessoaJuridica, cnpj: cnpj)
    |> case do
      nil ->
        Repo.transaction(fn ->
          {:ok, pessoa} = Repo.insert(%Pessoa{nome: nome, type: "juridica"})

          {:ok, pessoa_juridica} =
            %PessoaJuridica{}
            |> PessoaJuridica.changeset(%{cnpj: cnpj})
            |> Ecto.Changeset.put_assoc(:pessoa, pessoa)
            |> Repo.insert()

          {:ok, endereco} =
            pessoa_juridica
            |> Ecto.build_assoc(:enderecos)
            |> Endereco.changeset(endereco)
            |> Repo.insert()

          {pessoa_juridica, endereco}
        end)

      _ ->
        {:error, "Já existe um cadastro para este CNPJ."}
    end
  end
end
