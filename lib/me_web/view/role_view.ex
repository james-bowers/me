defmodule MeWeb.RoleView do
  use MeWeb, :view
  alias MeWeb.View
  alias Me.{Role, Person, Account, Email}

  @display_attributes [:id, :active]

  def render({:error, changeset}, :link, conn) do
    conn
    |> send_json(400, %View{
      description: "Invalid link request",
      content: format_changeset(changeset)
    })
  end

  def render(
        {:ok,
         %{
           role: role = %Role{},
           token: token
         }},
        :link,
        conn
      ) do
    conn
    |> send_json(200, %View{
      description: "Account linked to person",
      content: %{
        token: token,
        role: Map.take(role, [:id, :account_id, :person_id, :permission_level])
      }
    })
  end

  def render(
        role = %Role{
          person: person = %Person{email: emails = [%Email{}]},
          account: account = %Account{}
        },
        :validate,
        conn
      ) do
    conn
    |> send_json(200, %View{
      description: "Role validated",
      content: %{
        role: Map.take(role, [:id, :account_id, :person_id]),
        person: Map.take(person, [:id, :first_name, :last_name]),
        account: Map.take(account, [:id, :active]),
        email: format_emails(emails)
      }
    })
  end

  def render(
        role = %Role{
          person: person = %Person{},
          account: account = %Account{}
        },
        :validate,
        conn
      ) do
    conn
    |> send_json(200, %View{
      description: "Anonymous user role validated",
      content: %{
        role: Map.take(role, [:id, :account_id, :person_id]),
        person: Map.take(person, [:id, :first_name, :last_name]),
        account: Map.take(account, [:id, :active])
      }
    })
  end

  def format_emails(emails) do
    emails
    |> Enum.reduce([], fn email, emails_list ->
      [email.email] ++ emails_list
    end)
  end

  def render({:error, _error}, :validate, conn) do
    conn
    |> send_json(400, %View{
      description: "Invalid token",
      content: nil
    })
  end

  def render(nil, :validate, conn) do
    conn
    |> send_json(404, %View{
      description: "Role not found",
      content: nil
    })
  end
end
