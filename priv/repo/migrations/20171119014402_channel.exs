defmodule ServerSide451.Repo.Migrations.Channel do
  use Ecto.Migration

	def change do
		create table(:channel) do
			add :channel_number, :integer
			add :available, :integer
			add :master, :integer

			timestamps()
		end

	create unique_index(:channel, [:channel_number])
	end
end
