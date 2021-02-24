defmodule CaminoChallenge.Contratos.Repositories.ContratoRepository do
  @moduledoc """
  The Contratos context.
  """

  # "e9bdc6e5-4163-44b7-b57b-14d6e3844b6a, e6f26185-f54c-48f9-ba8f-346e5a54355c"

  import Ecto.Query, warn: false

  alias CaminoChallenge.Repo
  require Logger
  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Contratos.Entities.Upload
  alias CaminoChallenge.Contratos.Entities.PartesContrato

  @doc """
  Returns the list of contratos.

  ## Examples

      iex> list_contratos()
      [%Contrato{}, ...]

  """
  def list_contratos do
    Repo.all(Contrato)
  end

  @doc """
  Gets a single contrato.

  Raises `Ecto.NoResultsError` if the Contrato does not exist.

  ## Examples

      iex> get_contrato!(123)
      %Contrato{}

      iex> get_contrato!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contrato!(id), do: Repo.get!(Contrato, id)

  @doc """
  Creates a contrato.

  ## Examples

      iex> create_contrato(%{field: value})
      {:ok, %Contrato{}}

      iex> create_contrato(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_contrato(attrs \\ %{}) do
  #   Logger.debug(attrs)
  #   # %Contrato{}
  #   # |> Contrato.changeset(attrs)
  #   # |> Repo.insert()
  # end

  def create_contrato(attrs \\ %{}) do
    nome = attrs["nome"] || attrs.nome
    descricao = attrs["descricao"] || attrs.descricao
    data_str = attrs["data"] || attrs.data
    partes = attrs["partes"] || attrs.partes
    arquivo = attrs["arquivo"] || attrs.arquivo

    {:ok, data} = Date.from_iso8601(data_str)
    ids_parts_list = String.split(partes, ",")

    Repo.transaction(fn ->
      # 1. Insert dados do contrato
      {:ok, contrato} = Repo.insert(%Contrato{nome: nome, descricao: descricao, data: data})

      # 2. Insert file
      {:ok, upload} = contrato
      |> Ecto.build_assoc(:uploads)
      |> Upload.changeset(%{
        "arquivo" => arquivo,
        "filename" => arquivo.filename,
        "content_type" => arquivo.content_type
      })
      |> Repo.insert()

      Repo.insert_all(
        PartesContrato,
        ids_parts_list
        |> Enum.map(fn item ->
          %{
            pessoa_id: item,
            contrato_id: contrato.id
          }
        end)
      )
      {contrato, upload}

    end)

  end
end
