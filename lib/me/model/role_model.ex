defmodule Me.RoleModel do
  alias Me.{Role, Repo}

  def get(role = %Role{}) do
    Repo.get(Role, role.id)
    |> Repo.preload([:person, :account])
    |> Repo.preload([{:person, :email}, :person])
  end
end
