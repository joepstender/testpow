defmodule Testpow.Repo.Migrations.AddSlugToTenants do
  use Ecto.Migration

  def change do
    alter table(:tenants) do
      add :slug, :string
    end

    create unique_index(:tenants, [:slug])
  end
end
