defmodule MeWeb.PersonView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Account, Guardian}

  @display_attributes [:id, :active]

  def render({:ok, role_token, claims}, :login, conn) do
    conn
    |> send_json(200, %View{
      description: "Logged in the user.",
      content: %{
        token: role_token,
        claims: %{
          expires: claims["exp"]
        }
      }
    })
  end

  def render({:error, reason}, :login, conn) do
    conn
    |> send_json(400, %View{
      description: "Failed to login the user.",
      content: nil
    })
  end

  def render({:error, :secret_not_found}, :login, conn) do
    conn
    |> send_json(500, %View{
      description: "Sorry, we have failed.",
      content: nil
    })
  end
end
