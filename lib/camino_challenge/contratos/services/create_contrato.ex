defmodule CaminoChallenge.Contratos.Services.CreateContrato do
  alias CaminoChallenge.Contratos.Repositories.ContratoRepository

  require Logger

  def execute(contrato) do
    ContratoRepository.create_contrato(contrato)
  end
end
