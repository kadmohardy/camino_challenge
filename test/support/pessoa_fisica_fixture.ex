defmodule CaminoChallenge.PessoaFisicaFixture do
  def valid_pessoa_fisica,
    do: %{
      cpf: "some cpf",
      data_nascimento: ~D[2010-04-17],
      nome: "some nome"
    }

  def update_pessoa_fisica,
    do: %{
      cpf: "some updated cpf",
      data_nascimento: ~D[2011-05-18],
      nome: "some updated nome"
    }

  def invalid_pessoa_fisica, do: %{cpf: nil, data_nascimento: nil, nome: nil}
end
