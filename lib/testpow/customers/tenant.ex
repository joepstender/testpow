defmodule Testpow.Customers.Tenant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tenants" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> slugify_name()
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end

  defp slugify_name(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, new_name} ->
        put_change(changeset, :slug, slugify(new_name))

      :error ->
        changeset
    end
  end

  defp slugify(string) do
    string
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "")
  end
end
