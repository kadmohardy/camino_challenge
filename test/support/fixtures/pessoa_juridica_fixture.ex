defmodule CaminoChallenge.Fixtures.PessoaJuridicaFixture do
  def valid_pessoa_juridica,
    do: %{
      cnpj: "75569839000144",
      nome: "some nome",
      endereco: %{
        cep: "12345450",
        cidade: "Sobral",
        uf: "CE",
        pais: "Brasil",
        rua: "Rua Um, 21"
      }
    }

  def invalid_pessoa_juridica,
    do: %{
      cnpj: "123456789104321",
      nome: "some nome",
      endereco: %{}
    }
end
