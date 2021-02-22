defmodule CaminoChallenge.PessoasJuridicas.Repositories.PessoaJuridicaRepository do
  @moduledoc """
  The PessoasJuridicas context.
  """
  require Logger
  import Ecto.Query, warn: false
  alias CaminoChallenge.PessoasJuridicas.Entities.Endereco
  alias CaminoChallenge.PessoasJuridicas.Entities.PessoaJuridica
  alias CaminoChallenge.Repo

  @doc """
  Returns the list of pessoas_juridicas.

  ## Examples

      iex> list_pessoas_juridicas()
      [%PessoaJuridica{}, ...]

  """
  def list_pessoas_juridicas, do: Repo.all(PessoaJuridica) |> Repo.preload(:enderecos)

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
  def create_pessoa_juridica(%{"nome" => nome, "cnpj" => cnpj, "endereco" => endereco}) do

    Repo.get_by(PessoaJuridica, cnpj: cnpj)
    |> case do
      nil ->
        Repo.transaction(fn ->
          pessoa_juridica = Repo.insert!(%PessoaJuridica{nome: nome, cnpj: cnpj})

          %Endereco{}
          |> Endereco.changeset(endereco)
          |> Ecto.Changeset.put_assoc(:pessoa_juridica, pessoa_juridica)
          |> Repo.insert()
        end)

      user ->
        {:error, "Já existe um cadastro para este CNPJ."}
    end
  end

  @doc """
  Updates a pessoa_juridica.

  ## Examples

      iex> update_pessoa_juridica(pessoa_juridica, %{field: new_value})
      {:ok, %PessoaJuridica{}}

      iex> update_pessoa_juridica(pessoa_juridica, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pessoa_juridica(%PessoaJuridica{} = pessoa_juridica, attrs) do
    pessoa_juridica
    |> PessoaJuridica.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pessoa_juridica.

  ## Examples

      iex> delete_pessoa_juridica(pessoa_juridica)
      {:ok, %PessoaJuridica{}}

      iex> delete_pessoa_juridica(pessoa_juridica)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pessoa_juridica(%PessoaJuridica{} = pessoa_juridica) do
    Repo.delete(pessoa_juridica)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pessoa_juridica changes.

  ## Examples

      iex> change_pessoa_juridica(pessoa_juridica)
      %Ecto.Changeset{data: %PessoaJuridica{}}

  """
  def change_pessoa_juridica(%PessoaJuridica{} = pessoa_juridica, attrs \\ %{}) do
    PessoaJuridica.changeset(pessoa_juridica, attrs)
  end
end
