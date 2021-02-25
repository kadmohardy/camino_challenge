defmodule CaminoChallenge.Contratos.Entities.PartesContrato do
  use Ecto.Schema
  import Ecto.Changeset

  alias CaminoChallenge.Pessoas.Entities.Pessoa
  alias CaminoChallenge.Contratos.Entities.Contrato

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "contratos_partes" do
    field :pessoa_id, :binary_id, foreign_key: :pessoa_id, references: :id
    field :contrato_id, :binary_id, foreign_key: :contrato_id, references: :id

    belongs_to :pessoa, Pessoa, define_field: false
    belongs_to :contrato, Contrato, define_field: false
  end

  @doc false
  def changeset(contrato, attrs) do
    contrato
    |> cast(attrs, [:pessoa_id, :contrato_id])
    |> foreign_key_constraint(:pessoa_id)
    |> foreign_key_constraint(:contrato_id)
  end
end
