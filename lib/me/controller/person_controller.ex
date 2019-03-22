defmodule Me.PersonController do
  alias Me.{Role, Person, Password, PersonModel, RoleController}

  def login(%{password: password, email: email}) do
    PersonModel.get_by_email(email)
    |> validate_password(password)
    |> format_login_result()
  end

  def validate_password(person = %Person{password: %Password{}}, password) do
    case Bcrypt.check_pass(person.password, password) do
      {:ok, _} -> {:ok, person}
      {:error, reason} -> {:error, reason}
    end
  end

  defp format_login_result({:ok, person = %Person{role: [%Role{}]}}) do
    person.role
    |> Enum.fetch!(0)
    |> RoleController.sign()
  end

  defp format_login_result({:error, _message} = result) do
    result
  end
end
