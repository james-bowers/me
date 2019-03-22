defmodule Me.RoleController do
  alias Me.{Role, Guardian, RoleModel}

  def sign(role = %Role{}) do
    Me.Guardian.encode_and_sign(role)
  end

  def validate(token) do
    Guardian.decode_and_verify(token)
  end

  def fetch_resource(%{"sub" => role_id} = claims) do
    RoleModel.get(%Role{id: role_id})
  end
end
