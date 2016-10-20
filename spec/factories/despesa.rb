FactoryGirl.define do
  factory :despesa do
    sequence(:matricula) { |n| n }

    beneficiario "beneficiario"
    data_emissao Time.now
    valor_liquido 10.0
    cpf_cnpj "12345"
    num_mes 1
    num_ano 2015
    num_parcela 0
    id_cadastro 1234
    descricao "descricao"
    nome_parlamentar "nome"
    valor_documento 10.0
    valor_glosa 10.0
    num_lote 123
    num_ressarcimento 123
    num_sub_cota 123
    num_especificacao_sub_cota 123
    numero 123
    url_recibo "http://www.url.com/recibo"
    ide_documento "1234"
  end
end
