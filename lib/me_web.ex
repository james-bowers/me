defmodule MeWeb do
  # web logic space

  def view do
    quote do
      import Plug.Conn
      import MeWeb.View
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
