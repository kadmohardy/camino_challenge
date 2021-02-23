defmodule CaminoChallengeWeb.Api.EnderecoView do
  use CaminoChallengeWeb, :view

  def render("show.json", %{endereco: endereco}) do
    render_one(endereco, __MODULE__, "endereco.json")
  end

  def render("endereco.json", %{endereco: endereco}) do
    %{
      pais: endereco.pais,
      uf: endereco.uf,
      cidade: endereco.cidade,
      rua: endereco.rua,
      cep: endereco.cep
    }
  end
end
