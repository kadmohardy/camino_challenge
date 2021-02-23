defmodule CaminoChallenge.Pessoas.Entities.PessoaFisica do
  use Ecto.Schema
  import Ecto.Changeset
  alias CaminoChallenge.Pessoas.Entities.Pessoa

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "pessoas_fisicas" do
    field :cpf, :string
    field :data_nascimento, :date
    field :pessoa_id, :binary_id, foreign_key: :pessoa_id, references: :id

    belongs_to :pessoa, Pessoa, define_field: false

    timestamps()
  end

  @doc false
  def changeset(pessoa_fisica, attrs) do
    pessoa_fisica
    |> cast(attrs, [:cpf, :data_nascimento])
    |> validate_required([:cpf, :data_nascimento])
    |> unique_constraint(:cpf)
  end
end
