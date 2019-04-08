defmodule MeWeb.AccountView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Account}

  @display_attributes [:id, :active]

  def render({:ok, %{account: account = %Account{}}}, :new_account, conn) do
    conn
    |> send_json(200, %View{
      description: "A new, unlinked account has been created.",
      content: %{
        account: Map.take(account, @display_attributes)
      }
    })
  end
end
