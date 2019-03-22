defmodule MeWeb.RoleView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Role}

  @display_attributes [:id, :active]

  def render(role = %Role{}, :validate, conn) do
    conn
    |> send_json(200, %View{
      description: "Role validated",
      content: %{
        role: Map.take(role, [:id, :account_id, :person_id])
      }
    })
  end

  def render({:error, _error}, :validate, conn) do
    conn
    |> send_json(400, %View{
      description: "Invalid token",
      content: nil
    })
  end
end
