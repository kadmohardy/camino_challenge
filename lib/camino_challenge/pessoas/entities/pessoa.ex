defmodule CaminoChallenge.Pessoas.Entities.Pessoa do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "pessoas" do
    field :nome, :string
    field :type, :string
    timestamps()
  end

  @doc false
  def changeset(pessoa_fisica, attrs) do
    pessoa_fisica
    |> cast(attrs, [:nome, :type])
    |> validate_required([:nome, :type])
    |> validate_inclusion(:type, ["fisica", "juridica"])
  end
end
