defmodule CaminoChallengeWeb.Api.PessoaJuridicaView do
  use CaminoChallengeWeb, :view

  require Logger
  alias CaminoChallengeWeb.Api.EnderecoView

  def render("index.json", %{pessoas_juridicas: pessoas_juridicas}) do
    %{data: render_many(pessoas_juridicas, __MODULE__, "pessoa_juridica.json")}
  end

  def render("show.json", %{pessoa_juridica: pessoa_juridica}) do
    %{data: render_one(pessoa_juridica, __MODULE__, "pessoa_juridica.json")}
  end

  def render("pessoa_juridica.json", %{pessoa_juridica: pessoa_juridica}) do

    %{
      id: pessoa_juridica.pessoa_id,
      nome: pessoa_juridica.pessoa.nome,
      type: pessoa_juridica.pessoa.type,
      cnpj: pessoa_juridica.cnpj,
      endereco: render_one(pessoa_juridica.enderecos, EnderecoView, "endereco.json")
    }
  end
end
