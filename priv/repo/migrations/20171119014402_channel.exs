defmodule ServerSide451.Repo.Migrations.Channel do
  use Ecto.Migration

	def change do
		create table(:channel) do
			add :channel_number, :string
			add :available_users, :jsonb
			add :master, :string

			timestamps()
		end

	create unique_index(:channel, [:master])
	end
end
