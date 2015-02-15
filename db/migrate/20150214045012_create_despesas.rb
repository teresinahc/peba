class CreateDespesas < ActiveRecord::Migration
  def change
    create_table :despesas do |t|
      t.string :matricula
      t.string :beneficiario
      t.date :data_emissao
      t.string :valor_liquido
      t.string :cpf_cnpj
      t.integer :num_mes
      t.integer :num_ano
      t.integer :num_parcela
      t.integer :id_cadastro
      t.references :deputado, index: true

      t.timestamps null: false
    end
    add_foreign_key :despesas, :deputados
  end
end
