defmodule CaminoChallenge.Contratos.Services.ListContratos do
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository
  alias CaminoChallenge.Validations

  def execute(filter) do
    pessoa_id = filter["pessoa_id"]
    data = filter["data"]

    cond do
      pessoa_id != nil && !Validations.valid_uuid(pessoa_id) ->
        {:error, "pessoa_id representa um uuid invalido"}

      data != nil && !Validations.is_date(data) ->
        {:error, "data represent um formato invalido. Por favor utilize o formato yyyy-mm-dd"}

      true ->
        ContratoRepository.list_contratos(filter)
    end
  end
end
