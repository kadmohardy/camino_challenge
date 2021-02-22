defmodule CaminoChallenge.PessoasJuridicas.Entities.PessoaJuridica do
  use Ecto.Schema
  import Ecto.Changeset

  alias CaminoChallenge.PessoasJuridicas.Entities.Endereco

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "pessoas_juridicas" do
    field :cnpj, :string
    field :nome, :string

    has_one :enderecos, Endereco

    timestamps()
  end

  @doc false
  def changeset(pessoa_juridica, attrs) do
    pessoa_juridica
    |> cast(attrs, [:nome, :cnpj])
    |> validate_required([:nome, :cnpj])
    |> unique_constraint(:cnpj)
  end
end
