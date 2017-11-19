defmodule ServerSide451.Repo.Migrations.User do
  use Ecto.Migration

	def change do
		create table(:users) do
			add :phone_number, :string
			add :mac_address, :string
			add :user_id, references(:users, on_delete: :delete_all), null: false

			timestamps()
		end
	create unique_index(:users, [:phone_number])

	end	
end
