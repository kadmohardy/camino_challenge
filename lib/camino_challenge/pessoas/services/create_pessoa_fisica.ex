defmodule CaminoChallenge.Pessoas.Services.CreatePessoaFisica do
  alias CaminoChallenge.Pessoas.Repositories.PessoaFisicaRepository
  alias CaminoChallenge.Validations

  def execute(pessoa) do
    pessoa_id = pessoa["cpf"]
    data_nascimento = pessoa["data_nascimento"]

    cond do
      pessoa_id != nil && !Validations.valid_uuid(pessoa_id) ->
        {:error, "pessoa_id representa um uuid invalido"}

      data_nascimento != nil && !Validations.is_date(data_nascimento) ->
        {:error, "data represent um formato invalido. Por favor utilize o formato yyyy-mm-dd"}

      true ->
        PessoaFisicaRepository.create_pessoa_fisica(pessoa)
    end
  end
end
