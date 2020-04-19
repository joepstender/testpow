defmodule TestpowWeb.RegistrationController do
  use TestpowWeb, :controller

  # Set tenant as third argument for all actions
  def action(conn, _) do
    tenant = Testpow.Customers.get_tenant!(conn.params["tenant_id"])
    args = [conn, conn.params, tenant]
    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, _params, tenant) do
    # We'll leverage [`Pow.Plug`](Pow.Plug.html), but you can also follow the classic Phoenix way:
    # changeset = MyApp.Users.User.changeset(%MyApp.Users.User{}, %{})

    changeset = Pow.Plug.change_user(conn)

    render(conn, "new.html", changeset: changeset, tenant: tenant)
  end

  def create(conn, %{"user" => user_params}, tenant) do
    # We'll leverage [`Pow.Plug`](Pow.Plug.html), but you can also follow the classic Phoenix way:
    # user =
    #   %MyApp.Users.User{}
    #   |> MyApp.Users.User.changeset(user_params)
    #   |> MyApp.Repo.insert()

    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> redirect(to: Routes.tenant_path(conn, :show, tenant))

      {:error, changeset, conn} ->
        render(conn, "new.html", changeset: changeset, tenant: tenant)
    end
  end
end
