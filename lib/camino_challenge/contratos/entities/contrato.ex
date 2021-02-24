defmodule CaminoChallenge.Contratos.Entities.Contrato do
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

  @doc false
  def changeset(contrato, attrs) do
    contrato
    |> cast(attrs, [:nome, :descricao, :data])
    |> cast_attachments(attrs, [:arquivo])
    |> validate_required([:nome, :descricao, :data])
  end
end
