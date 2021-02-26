defmodule CaminoChallenge.Pessoas.Services.CreatePessoaJuridica do
  alias CaminoChallenge.Pessoas.Repositories.PessoaJuridicaRepository

  def execute(pessoa) do
    PessoaJuridicaRepository.create_pessoa_juridica(pessoa)
  end
end
