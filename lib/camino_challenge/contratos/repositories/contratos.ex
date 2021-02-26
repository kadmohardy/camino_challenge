defmodule CaminoChallenge.Contratos.Repositories.ContratoRepository do
  @moduledoc """
  The Contratos context.
  """
  import Ecto.Query, warn: false

  alias CaminoChallenge.Repo
  require Logger
  alias CaminoChallenge.Contratos.Entities.{Contrato, PartesContrato, Upload}
  alias CaminoChallenge.Pessoas.Entities.{PessoaFisica, PessoaJuridica}

  @doc """
  Returns the list of contratos.

  ## Examples

      iex> list_contratos()
      [%Contrato{}, ...]

  """

  def pessoas_fisicas_repo, do: Repo.all(PessoaFisica) |> Repo.preload(:pessoa)

  def pessoas_juridicas_repo,
    do: Repo.all(PessoaJuridica) |> Repo.preload([:pessoa, :enderecos])

  def load_pessoa_fisica_map(nil), do: nil

  def load_pessoa_fisica_map(item),
    do: %{
      pessoa_id: item.pessoa.id,
      nome: item.pessoa.nome,
      data_nascimento: item.data_nascimento,
      cpf: item.cpf
    }

  def load_pessoa_juridica_map(nil), do: nil

  def load_pessoa_juridica_map(item),
    do: %{
      pessoa_id: item.pessoa.id,
      nome: item.pessoa.nome,
      cnpj: item.cnpj,
      endereco: %{
        rua: item.enderecos.rua,
        cep: item.enderecos.cep,
        cidade: item.enderecos.cidade,
        pais: item.enderecos.pais,
        uf: item.enderecos.uf
      }
    }

  def load_pessoas_fisicas(pessoas_fisicas_repo, partes) do
    list =
      partes
      |> Enum.map(fn item ->
        Enum.find(pessoas_fisicas_repo, &(&1.pessoa_id == item.pessoa.id))
        |> load_pessoa_fisica_map()
      end)

    Enum.reject(list, &is_nil/1)
  end

  def load_pessoas_juridicas(pessoas_juridicas_repo, partes) do
    list =
      partes
      |> Enum.map(fn item ->
        Enum.find(pessoas_juridicas_repo, &(&1.pessoa_id == item.pessoa.id))
        |> load_pessoa_juridica_map()
      end)

    Enum.reject(list, &is_nil/1)
  end

  def list_contratos_por_filtro(pessoa_id, nil) do
    pessoas_fisicas = pessoas_fisicas_repo()
    pessoas_juridicas = pessoas_juridicas_repo()

    Repo.all(
      from u in Contrato,
        join: partes in assoc(u, :partes_contrato),
        where: partes.pessoa_id == ^pessoa_id,
        preload: [{:partes_contrato, :pessoa}, :uploads]
    )
    |> get_partes_for_contrato(pessoas_fisicas, pessoas_juridicas)
  end

  def list_contratos_por_filtro(nil, data) do
    pessoas_fisicas = pessoas_fisicas_repo()
    pessoas_juridicas = pessoas_juridicas_repo()

    Repo.all(
      from u in Contrato,
        join: partes in assoc(u, :partes_contrato),
        where: u.data == ^data,
        preload: [{:partes_contrato, :pessoa}, :uploads]
    )
    |> get_partes_for_contrato(pessoas_fisicas, pessoas_juridicas)
  end

  def list_contratos_por_filtro(pessoa_id, data) do
    pessoas_fisicas = pessoas_fisicas_repo()
    pessoas_juridicas = pessoas_juridicas_repo()

    Repo.all(
      from u in Contrato,
        join: partes in assoc(u, :partes_contrato),
        where: partes.pessoa_id == ^pessoa_id and u.data == ^data,
        preload: [{:partes_contrato, :pessoa}, :uploads]
    )
    |> get_partes_for_contrato(pessoas_fisicas, pessoas_juridicas)
  end

  def list_contratos(%{"pessoa_id" => pessoa_id, "data" => data}),
    do: {:ok, list_contratos_por_filtro(pessoa_id, data)}

  def list_contratos(%{"pessoa_id" => pessoa_id}),
    do: {:ok, list_contratos_por_filtro(pessoa_id, nil)}

  def list_contratos(%{"data" => data}), do: {:ok, list_contratos_por_filtro(nil, data)}

  def list_contratos do
    # 1. Obtem todos as pessoas fisicas e armazena em memoria
    pessoas_fisicas = pessoas_fisicas_repo()
    pessoas_juridicas = pessoas_juridicas_repo()

    {:ok,
     Repo.all(
       from u in Contrato,
         preload: [{:partes_contrato, :pessoa}, :uploads]
     )
     |> get_partes_for_contrato(pessoas_fisicas, pessoas_juridicas)}
  end

  defp get_partes_for_contrato(contratos, pessoas_fisicas, pessoas_juridicas) do
    contratos
    |> Enum.map(fn contrato ->
      %{
        id: contrato.id,
        nome: contrato.nome,
        descricao: contrato.descricao,
        data: contrato.data,
        partes: %{
          pessoas_fisicas: load_pessoas_fisicas(pessoas_fisicas, contrato.partes_contrato),
          pessoas_juridicas: load_pessoas_juridicas(pessoas_juridicas, contrato.partes_contrato)
        },
        arquivo: contrato.uploads.filename
      }
    end)
  end

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
      contrato =
        case Repo.insert(%Contrato{nome: nome, descricao: descricao, data: data}) do
          {:ok, contrato} -> contrato
          {:error, changeset} -> Repo.rollback(changeset)
        end

      upload =
        case contrato
             |> Ecto.build_assoc(:uploads)
             |> Upload.changeset(%{
               "arquivo" => arquivo,
               "filename" => arquivo.filename,
               "content_type" => arquivo.content_type
             })
             |> Repo.insert() do
          {:ok, upload} -> upload
          {:error, changeset} -> Repo.rollback(changeset)
        end

      ids_parts_list
      |> Enum.map(fn item ->
        %PartesContrato{}
        |> PartesContrato.changeset(%{
          "pessoa_id" => item,
          "contrato_id" => contrato.id
        })
        |> Repo.insert()
      end)

      {contrato, upload}
    end)
  end
end
