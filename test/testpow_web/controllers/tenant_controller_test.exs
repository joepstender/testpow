defmodule TestpowWeb.TenantControllerTest do
  use TestpowWeb.ConnCase

  alias Testpow.Customers

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:tenant) do
    {:ok, tenant} = Customers.create_tenant(@create_attrs)
    tenant
  end

  describe "index" do
    test "lists all tenants", %{conn: conn} do
      conn = get(conn, Routes.tenant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tenants"
    end
  end

  describe "new tenant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tenant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tenant"
    end
  end

  describe "create tenant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tenant_path(conn, :create), tenant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tenant_path(conn, :show, id)

      conn = get(conn, Routes.tenant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tenant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tenant_path(conn, :create), tenant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tenant"
    end
  end

  describe "edit tenant" do
    setup [:create_tenant]

    test "renders form for editing chosen tenant", %{conn: conn, tenant: tenant} do
      conn = get(conn, Routes.tenant_path(conn, :edit, tenant))
      assert html_response(conn, 200) =~ "Edit Tenant"
    end
  end

  describe "update tenant" do
    setup [:create_tenant]

    test "redirects when data is valid", %{conn: conn, tenant: tenant} do
      conn = put(conn, Routes.tenant_path(conn, :update, tenant), tenant: @update_attrs)
      assert redirected_to(conn) == Routes.tenant_path(conn, :show, tenant)

      conn = get(conn, Routes.tenant_path(conn, :show, tenant))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, tenant: tenant} do
      conn = put(conn, Routes.tenant_path(conn, :update, tenant), tenant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tenant"
    end
  end

  describe "delete tenant" do
    setup [:create_tenant]

    test "deletes chosen tenant", %{conn: conn, tenant: tenant} do
      conn = delete(conn, Routes.tenant_path(conn, :delete, tenant))
      assert redirected_to(conn) == Routes.tenant_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tenant_path(conn, :show, tenant))
      end
    end
  end

  defp create_tenant(_) do
    tenant = fixture(:tenant)
    {:ok, tenant: tenant}
  end
end
