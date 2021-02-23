defmodule CaminoChallenge.Contratos.Entities.Contrato do
  use Ecto.Schema
  import Ecto.Changeset
  alias CaminoChallenge.Contratos.Entities.PartesContrato

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "contratos" do
    field :data, :date
    field :descricao, :string
    field :file, :string
    field :nome, :string

    many_to_many :partes_contrato, PartesContrato, join_through: "contratos_partes"

    timestamps()
  end

  @doc false
  def changeset(contrato, attrs) do
    contrato
    |> cast(attrs, [:file, :nome, :descricao, :data, :lista_partes])
    |> validate_required([:file, :nome, :descricao, :data, :lista_partes])
  end
end
