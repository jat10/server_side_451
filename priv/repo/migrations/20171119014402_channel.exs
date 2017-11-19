defmodule ServerSide451.Repo.Migrations.Channel do
  use Ecto.Migration

	def change do
		create table(:channel) do
			add :channel_number, :string
			add :available_users, :jsonb
			add :master, references(:users, on_delete: :delete_all), null: false

			timestamps()
		end
	end
end
