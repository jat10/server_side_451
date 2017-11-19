defmodule ServerSide451.Repo.Migrations.Channel do
  use Ecto.Migration

	def change do
		create table(:channel) do
			add :channel_number, :string
			add :slaves, :jsonb
			add :available, :integer
			add :master, :integer

			timestamps()
		end

	create unique_index(:channel, [:master])
	end
end
