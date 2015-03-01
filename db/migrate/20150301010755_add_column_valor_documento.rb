class AddColumnValorDocumento < ActiveRecord::Migration
  def change
  	add_column :despesas, :valor_documento, :string
  	add_column :despesas, :valor_glosa, :string
  end
end
