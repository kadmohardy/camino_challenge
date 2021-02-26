defmodule CaminoChallenge.Api.Params.PessoaJuridicaParams do
  use Params.Schema, %{
    nome: :string,
    cnpj: :string,
    endereco: %{
      cep: :string,
      cidade: :string,
      uf: :string,
      pais: :string,
      rua: :string
    }
  }

  # only: [cast: 3, validate_inclusion: 3]
  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [:nome, :cnpj])
    |> cast_embed(:endereco)
    |> validate_required([:nome, :cnpj, :endereco])
    |> validate_length(:cnpj,
      min: 14,
      max: 14,
      message: "CNPJ deve ter 14 caracteress. Siga o formato XXXXXXXXXXX"
    )
    |> validate_cnpj_is_valid()
  end

  defp validate_cnpj_is_valid(changeset) do
    cpf_value = %Cnpj{number: get_field(changeset, :cnpj)}

    if Brcpfcnpj.cnpj_valid?(cpf_value) do
      changeset
    else
      add_error(changeset, :cnpj, "CNPJ inválido")
    end
  end
end
