defmodule CaminoChallengeWeb.Api.EnderecoView do
  @moduledoc false
  use CaminoChallengeWeb, :view

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
