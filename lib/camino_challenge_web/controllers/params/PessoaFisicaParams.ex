defmodule CaminoChallenge.Api.Params.PessoaFisicaParams do
  use Params.Schema, %{
    nome: :string,
    cpf: :string,
    data_nascimento: :date
  }

  # only: [cast: 3, validate_inclusion: 3]
  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [:nome, :cpf, :data_nascimento])
    |> validate_required([:nome, :cpf, :data_nascimento])
    |> validate_length(:cpf,
      min: 11,
      max: 11,
      message: "CPF deve ter 11 caracteress. Siga o formato XXXXXXXXXXX"
    )
    |> validate_cpf_is_valid()
  end

  defp validate_cpf_is_valid(changeset) do
    cpf_value = %Cpf{number: get_field(changeset, :cpf)}

    if Brcpfcnpj.cpf_valid?(cpf_value) do
      changeset
    else
      add_error(changeset, :cpf, "CPF inválido")
    end
  end
end
