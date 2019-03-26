defmodule MeWeb.AccountView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Account}

  @display_attributes [:id, :active]

  def render({:ok, %{token: token, account: account = %Account{}}}, :new_account, conn) do
    conn
    |> send_json(200, %View{
      description: "A new anonymous account has been created.",
      content: %{
        token: token,
        account: Map.take(account, @display_attributes)
      }
    })
  end
end
