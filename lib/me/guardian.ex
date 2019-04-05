defmodule Me.Guardian do
  use Guardian, otp_app: :me

  alias Me.Role

  def subject_for_token(resource = %Role{}, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end
end
