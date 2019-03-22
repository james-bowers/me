defmodule Me.Guardian do
  use Guardian, otp_app: :me

  alias Me.{Role, RoleModel}

  def subject_for_token(resource = %Role{}, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    # case Me.AccountModel.get(%Role{id: id}) do
    #   resource -> {:ok, resource}
    #   nil -> {:error, :not_found}
    # end
  end
end
