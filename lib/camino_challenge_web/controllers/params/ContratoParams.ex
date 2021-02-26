defmodule CaminoChallenge.Api.Params.ContratoParams do
  alias CaminoChallenge.Validations
  require Logger

  use Params.Schema, %{
    nome: :string,
    descricao: :string,
    partes: :string,
    data: :date,
    arquivo: CaminoChallenge.Uploaders.Pdf.Type
  }

  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [:nome, :descricao, :data, :partes, :arquivo])
    |> validate_required([:nome, :descricao, :data, :partes, :arquivo])
    |> validate_partes_list()
  end

  defp validate_partes_list(changeset) do
    get_field(changeset, :partes)
    |> validate_uuid_partes_list(changeset)
  end

  defp validate_uuid_partes_list(nil, changeset),
    do: add_error(changeset, :partes, "A lista não corresponde a UUIDs validos")

  defp validate_uuid_partes_list(uuids, changeset) do
    uuids_validation =
      Enum.all?(uuids |> String.split(","), fn item ->
        Validations.valid_uuid?(item)
      end)

    IO.puts(uuids_validation)

    if uuids_validation do
      changeset
    else
      add_error(changeset, :partes, "A lista não corresponde a UUIDs validos")
    end
  end
end
