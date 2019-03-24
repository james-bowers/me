defmodule MeWeb.PersonView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Account, Email, Role, Person, RoleController}

  def render({:ok, %{person: person = %Person{}, role: role = %Role{}, account: account = %Account{}, email: email = %Email{}}}, :sign_up, conn) do
    {:ok, token, _claims} = RoleController.sign(role)

    conn
    |> send_json(200, %View{
      description: "User signed up with a new account",
      content: %{
        token: token,
        person: Map.take(person, [:id]),
        role: Map.take(role, [:id]),
        account: Map.take(account, [:id]),
        email: Map.take(email, [:id, :email])
      }
    })
  end

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

  def render({:error, _reason}, :login, conn) do
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
