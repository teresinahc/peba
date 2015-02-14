class CreateDespesas < ActiveRecord::Migration
  def change
    create_table :despesas do |t|
      t.string :beneficiario
      t.string :cpf_cnpj
      t.string :valor
      t.references :deputado, index: true

      t.timestamps null: false
    end
    add_foreign_key :despesas, :deputados
  end
end
