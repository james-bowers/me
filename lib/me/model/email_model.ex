defmodule Me.EmailModel do
  alias Ecto.Multi
  alias Me.{Email}

  def insert(multi \\ Multi.new(), attrs = %{person_id: _person_id, email: _email}) do
    multi
    |> Multi.insert(:email, insert_changeset(attrs))
  end

  def insert_changeset(attrs) do
    %Email{}
    |> Email.changeset(attrs)
  end
end
