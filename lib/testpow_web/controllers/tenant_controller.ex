defmodule TestpowWeb.TenantController do
  use TestpowWeb, :controller

  alias Testpow.Customers
  alias Testpow.Customers.Tenant

  def index(conn, _params) do
    tenants = Customers.list_tenants()
    render(conn, "index.html", tenants: tenants)
  end

  def new(conn, _params) do
    changeset = Customers.change_tenant(%Tenant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tenant" => tenant_params}) do
    case Customers.create_tenant(tenant_params) do
      {:ok, tenant} ->
        conn
        |> put_flash(:info, "Tenant created successfully.")
        |> redirect(to: Routes.tenant_path(conn, :show, tenant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tenant = Customers.get_tenant!(id)
    render(conn, "show.html", tenant: tenant)
  end

  def edit(conn, %{"id" => id}) do
    tenant = Customers.get_tenant!(id)
    changeset = Customers.change_tenant(tenant)
    render(conn, "edit.html", tenant: tenant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tenant" => tenant_params}) do
    tenant = Customers.get_tenant!(id)

    case Customers.update_tenant(tenant, tenant_params) do
      {:ok, tenant} ->
        conn
        |> put_flash(:info, "Tenant updated successfully.")
        |> redirect(to: Routes.tenant_path(conn, :show, tenant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tenant: tenant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tenant = Customers.get_tenant!(id)
    {:ok, _tenant} = Customers.delete_tenant(tenant)

    conn
    |> put_flash(:info, "Tenant deleted successfully.")
    |> redirect(to: Routes.tenant_path(conn, :index))
  end
end
