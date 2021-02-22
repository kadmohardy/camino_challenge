defmodule CaminoChallengeWeb.Api.EnderecoView do
  use CaminoChallengeWeb, :view
  alias CaminoChallengeWeb.Api.EnderecoView

  def render("show.json", %{endereco: endereco}) do
    render_one(endereco, EnderecoView, "endereco.json")
  end

  def render("endereco.json", %{endereco: endereco}) do
    %{
      id: endereco.id,
      pais: endereco.pais,
      uf: endereco.uf,
      cidade: endereco.cidade,
      rua: endereco.rua,
      cep: endereco.cep
    }
  end
end
