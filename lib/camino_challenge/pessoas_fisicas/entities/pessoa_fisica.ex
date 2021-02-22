defmodule CaminoChallenge.PessoasFisicas.Entities.PessoaFisica do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "pessoas_fisicas" do
    field :cpf, :string
    field :data_nascimento, :date
    field :nome, :string

    timestamps()
  end

  @doc false
  def changeset(pessoa_fisica, attrs) do
    pessoa_fisica
    |> cast(attrs, [:nome, :cpf, :data_nascimento])
    |> validate_required([:nome, :cpf, :data_nascimento])
  end
end
