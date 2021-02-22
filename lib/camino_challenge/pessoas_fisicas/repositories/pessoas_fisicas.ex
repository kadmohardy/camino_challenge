defmodule CaminoChallenge.PessoasFisicas.Repositories.PessoaFisicaRepository do
  @moduledoc """
  The PessoasFisicas context.
  """

  import Ecto.Query, warn: false
  alias CaminoChallenge.Repo

  alias CaminoChallenge.PessoasFisicas.Entities.PessoaFisica

  @doc """
  Returns the list of pessoas_fisicas.

  ## Examples

      iex> list_pessoas_fisicas()
      [%PessoaFisica{}, ...]

  """
  def list_pessoas_fisicas do
    Repo.all(PessoaFisica)
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
  def create_pessoa_fisica(attrs \\ %{}) do
    %PessoaFisica{}
    |> PessoaFisica.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pessoa_fisica.

  ## Examples

      iex> update_pessoa_fisica(pessoa_fisica, %{field: new_value})
      {:ok, %PessoaFisica{}}

      iex> update_pessoa_fisica(pessoa_fisica, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pessoa_fisica(%PessoaFisica{} = pessoa_fisica, attrs) do
    pessoa_fisica
    |> PessoaFisica.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pessoa_fisica.

  ## Examples

      iex> delete_pessoa_fisica(pessoa_fisica)
      {:ok, %PessoaFisica{}}

      iex> delete_pessoa_fisica(pessoa_fisica)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pessoa_fisica(%PessoaFisica{} = pessoa_fisica) do
    Repo.delete(pessoa_fisica)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pessoa_fisica changes.

  ## Examples

      iex> change_pessoa_fisica(pessoa_fisica)
      %Ecto.Changeset{data: %PessoaFisica{}}

  """
  def change_pessoa_fisica(%PessoaFisica{} = pessoa_fisica, attrs \\ %{}) do
    PessoaFisica.changeset(pessoa_fisica, attrs)
  end
end
