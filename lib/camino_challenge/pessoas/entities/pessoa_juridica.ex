defmodule CaminoChallenge.Pessoas.Entities.PessoaJuridica do
  use Ecto.Schema
  import Ecto.Changeset

  alias CaminoChallenge.Pessoas.Entities.Endereco
  alias CaminoChallenge.Pessoas.Entities.Pessoa

  @primary_key {:id, :binary_id, autogenerate: true}
  # @foreign_key_type {:binary_id}
  @derive {Phoenix.Param, key: :id}
  schema "pessoas_juridicas" do
    field :cnpj, :string
    field :pessoa_id, :binary_id, foreign_key: :pessoa_id, references: :id

    belongs_to :pessoa, Pessoa, define_field: false
    has_one :endereco, Endereco

    timestamps()
  end

  @doc false
  def changeset(pessoa_juridica, attrs) do
    pessoa_juridica
    |> cast(attrs, [:cnpj])
    |> validate_required([:cnpj])
    |> cast_assoc(:enderecos, with: &Endereco.changeset/2)
    |> unique_constraint(:cnpj)
  end
end
