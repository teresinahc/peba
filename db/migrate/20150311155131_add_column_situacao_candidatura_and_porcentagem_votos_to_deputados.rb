class AddColumnSituacaoCandidaturaAndPorcentagemVotosToDeputados < ActiveRecord::Migration
  def change
    add_column :deputados, :situacao_candidatura, :string
    add_column :deputados, :porcentagem_votos, :float
  end
end
