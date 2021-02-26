defmodule CaminoChallenge.Pessoas.Services.CreatePessoaFisica do
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository

  def execute(pessoa) do
    PessoaFisicaRepository.create_pessoa_fisica(pessoa)
  end
end
