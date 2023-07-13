defmodule ExploreAuthWeb.AuthController do
  use ExploreAuthWeb, :controller
  plug Ueberauth

  alias ExploreAuth.UserFromAuth

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    auth
    |> UserFromAuth.extract_info()
    |> IO.inspect()
    redirect(conn, to: "/")
  end
end
