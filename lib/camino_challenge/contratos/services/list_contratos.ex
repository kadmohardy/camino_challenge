defmodule CaminoChallenge.Contratos.Services.ListContrato do
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  def execute(contrato) do
    ContratoRepository.list_contrato(contrato)
  end
end
