defmodule CaminoChallenge.Contratos.Entities.PartesContrato do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "partes_contratos" do
    field :data, :date
    field :descricao, :string
    has_many :contrato, Parte

    timestamps()
  end

  @doc false
  def changeset(contrato, attrs) do
    contrato
    |> cast(attrs, [:file, :nome, :descricao, :data, :lista_partes])
    |> validate_required([:file, :nome, :descricao, :data, :lista_partes])
  end
end
