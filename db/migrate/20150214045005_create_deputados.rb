class CreateDeputados < ActiveRecord::Migration
  def change
    create_table :deputados do |t|
      t.string :nome
      t.string :matricula
      t.string :url_foto
      t.string :partido
      t.string :email

      t.timestamps null: false
    end
  end
end
