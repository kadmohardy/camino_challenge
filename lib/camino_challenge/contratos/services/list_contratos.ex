defmodule CaminoChallenge.Contratos.Services.ListContratos do
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  def execute(filter) do
    ContratoRepository.list_contratos(filter)
  end
end
