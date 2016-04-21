class AddIdeDocumentoToDespesas < ActiveRecord::Migration
  def change
    add_column :despesas, :ide_documento, :integer
  end
end
