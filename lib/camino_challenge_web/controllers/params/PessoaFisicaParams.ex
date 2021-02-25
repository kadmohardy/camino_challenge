defmodule CaminoChallenge.Api.Params.PessoaFisicaParams do
  use Params.Schema, %{
    nome: :string,
    cpf: :string,
    data_nascimento: :date
  }

  # only: [cast: 3, validate_inclusion: 3]
  import Ecto.Changeset

  def child(ch, params) do
    IO.puts "validating paras =--=12-31=2-31=2-312=3-1=2-31-23"
    ch
    |> cast(params, [:nome, :cpf, :data_nascimento])
    |> validate_required([:nome, :cpf, :data_nascimento])
    |> validate_length(:cpf, min: 11, max: 11, message: "CPF deve ter 11 caracteress. Siga o formato XXXXXXXXXXX")
  end
end
