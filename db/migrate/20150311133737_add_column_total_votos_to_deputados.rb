class AddColumnTotalVotosToDeputados < ActiveRecord::Migration
  def change
    add_column :deputados, :total_votos, :int
  end
end
