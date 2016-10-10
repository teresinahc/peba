FactoryGirl.define do
  factory :deputado do
    sequence(:nome)             { |n| "deputado#{n}" }
    sequence(:nome_parlamentar) { |n| "dep#{n}" }
    sequence(:email)            { |n| "email#{n}@deputado.com" }
    sequence(:matricula)        { |n| n }

    url_foto "http://url.com/foto"
    partido "PDSK"
    uf "KD"
    id_cadastro "12345"
    total_votos 123
    porcentagem_votos 10.0
    situacao_candidatura "Eleito"

    factory :john_doe do
      nome "John Doe"
      nome_parlamentar "Jonny"
      email "john.doe@example.com"
      matricula 90

      url_foto "http://url.com/foto"
      partido "ANOTHER"
      uf "AN"
      id_cadastro "54321"
      total_votos 456
      porcentagem_votos 11.0
      situacao_candidatura "Eleito"
    end
  end
end
