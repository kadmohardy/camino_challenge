defmodule CaminoChallenge.Api.Params.ContratoParams do
  alias CaminoChallenge.Validations
  require Logger

  use Params.Schema, %{
    nome: :string,
    descricao: :string,
    partes: :string,
    data: :date,
    arquivo: CaminoChallenge.Uploders.Pdf.Type
  }

  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [:nome, :descricao, :data, :partes, :arquivo])
    |> validate_required([:nome, :descricao, :data, :partes, :arquivo])
    |> validate_uui_partes_list()
  end

  defp validate_uui_partes_list(changeset) do
    partes_list = get_field(changeset, :partes) |> String.split(",")

    partes_list_validation =
      partes_list
      |> Enum.map(fn item ->
        Validations.valid_uuid?(item)
      end)

    Logger.debug(partes_list_validation)

    if partes_list_validation do
      changeset
    else
      add_error(changeset, :partes, "A lista não corresponde a UUIDs validos")
    end
  end
end
