defmodule ServerSide451.Repo.Migrations.User do
  use Ecto.Migration

  def change do
	create table(:users) do
		add :phone_number, :string
		add :mac_address, :string
		add :user_name, :string
		add :ip_address, :string
		add :state, :string
		add :channel_id,  references(:channel, on_delete: :nothing),
                  null: false
		timestamps()
	end
	create unique_index(:users, [:phone_number])
  end
end
