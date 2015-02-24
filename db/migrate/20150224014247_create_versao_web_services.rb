class CreateVersaoWebServices < ActiveRecord::Migration
  def change
    create_table :versao_web_services do |t|
      t.string :url
      t.string :sha1hash
      t.date :data_arquivo

      t.timestamps null: false
    end
  end
end
