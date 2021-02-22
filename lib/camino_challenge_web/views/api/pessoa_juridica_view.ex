defmodule CaminoChallengeWeb.Api.PessoaJuridicaView do
  use CaminoChallengeWeb, :view

  alias CaminoChallengeWeb.Api.EnderecoView
  alias CaminoChallengeWeb.Api.PessoaJuridicaView

  def render("index.json", %{pessoas_juridicas: pessoas_juridicas}) do
    %{data: render_many(pessoas_juridicas, PessoaJuridicaView, "pessoa_juridica.json")}
  end

  def render("show.json", %{pessoa_juridica: pessoa_juridica}) do
    %{data: render_one(pessoa_juridica, PessoaJuridicaView, "pessoa_juridica.json")}
  end

  def render("pessoa_juridica.json", %{pessoa_juridica: pessoa_juridica}) do
    %{
      id: pessoa_juridica.id,
      nome: pessoa_juridica.nome,
      cnpj: pessoa_juridica.cnpj,
      endereco: EnderecoView.render("show.json", endereco: pessoa_juridica.enderecos)
    }
  end
end
