defmodule CaminoChallenge.Contratos.Entities.PartesContrato do
  @moduledoc """
    Module relativo a entidade de PartesContrato que é representa uma ligação
    entre um contrato e uma pessoa.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias CaminoChallenge.Contratos.Entities.Contrato
  alias CaminoChallenge.Pessoas.Entities.Pessoa

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "contratos_partes" do
    field :pessoa_id, :binary_id, foreign_key: :pessoa_id, references: :id
    field :contrato_id, :binary_id, foreign_key: :contrato_id, references: :id

    belongs_to :pessoa, Pessoa, define_field: false
    belongs_to :contrato, Contrato, define_field: false
  end

  @doc """
  A função `changeset/2` filtra, valida e define as restrições quando manipula-se
  estruturas de partes de contrato

  ##  Parâmetros da função
  - pessoa_id: código uuid da pessoa
  - contrato_id: código uuid do contrato
  """
  def changeset(partes_contrato, attrs) do
    partes_contrato
    |> cast(attrs, [:pessoa_id, :contrato_id])
    |> foreign_key_constraint(:pessoa_id)
    |> foreign_key_constraint(:contrato_id)
  end
end
