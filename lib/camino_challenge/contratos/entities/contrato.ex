defmodule CaminoChallenge.Contratos.Entities.Contrato do
  @moduledoc """
    Module relativo a entidade de contrato
  """
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  alias CaminoChallenge.Contratos.Entities.PartesContrato
  alias CaminoChallenge.Contratos.Entities.Upload

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "contratos" do
    field :data, :date
    field :descricao, :string
    field :nome, :string

    has_many :partes_contrato, PartesContrato
    has_one :uploads, Upload

    timestamps()
  end

  @doc """
  A função `changeset/2` filtra, valida e define as restrições quando manipula-se
  estruturas de contrato

  ##  Parâmetros da função
  - nome: nome do contrato
  - descricao: descrição do contrato
  - data: data da realização do contrato
  """
  def changeset(contrato, attrs) do
    contrato
    |> cast(attrs, [:nome, :descricao, :data])
    |> cast_attachments(attrs, [:arquivo])
    |> validate_required([:nome, :descricao, :data])
  end
end
