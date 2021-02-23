defmodule CaminoChallenge.Pessoas.Entities.Endereco do
  use Ecto.Schema
  import Ecto.Changeset

  alias CaminoChallenge.Pessoas.Entities.PessoaJuridica

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "enderecos" do
    field :cep, :string
    field :cidade, :string
    field :pais, :string
    field :rua, :string
    field :uf, :string

    belongs_to :pessoa_juridica, PessoaJuridica,
      foreign_key: :pessoa_juridica_id,
      type: :binary_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(adress, attrs) do
    adress
    |> cast(attrs, [:pais, :uf, :cidade, :rua, :cep])
    |> validate_required([:pais, :uf, :cidade, :rua, :cep])
  end
end
