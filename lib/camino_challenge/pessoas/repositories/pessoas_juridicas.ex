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
        try_insert_pessoa_juridica(nome, cnpj, endereco)

      _ ->
        {:error, "Já existe um cadastro para este CNPJ."}
    end
  end

  def try_insert_pessoa_juridica(nome, cnpj, endereco) do
    Repo.transaction(fn ->
      pessoa =
        case Repo.insert(%Pessoa{nome: nome, type: "juridica"}) do
          {:ok, pessoa} -> pessoa
          {:error, changeset} -> Repo.rollback(changeset)
        end

      pessoa_juridica =
        case %PessoaJuridica{}
             |> PessoaJuridica.changeset(%{cnpj: cnpj})
             |> Ecto.Changeset.put_assoc(:pessoa, pessoa)
             |> Repo.insert() do
          {:ok, pessoa_juridica} -> pessoa_juridica
          {:error, changeset} -> Repo.rollback(changeset)
        end

      endereco =
        case pessoa_juridica
             |> Ecto.build_assoc(:enderecos)
             |> Endereco.changeset(endereco)
             |> Repo.insert() do
          {:ok, endereco_res} -> endereco_res
          {:error, changeset} -> Repo.rollback(changeset)
        end

      {pessoa_juridica, endereco}
    end)
  end
end
