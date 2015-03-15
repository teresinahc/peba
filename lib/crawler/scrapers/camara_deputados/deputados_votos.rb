require "csv"

module Crawler::Scrapers
  class CamaraDeputados::DeputadosVotos < Base

    def initialize(url = 'https://raw.githubusercontent.com/juliobetta/eleicoes-2014/master/votos_eleitos_turno_1.csv')
      @url = url
    end

    def capturar
      atualiza_votos(pega_csv_votos)
    end

    private

    def atualiza_votos(resultados)

      atualizar_deputados_estaticamente

      resultados.each do |row|
        deputado = Deputado.find_by nome: row["Candidato"], partido: row["Partido"].gsub(/\s/, '')

        next if deputado.nil?

        deputado.update_attributes({
          total_votos:          row["Votação"].gsub(/\./, "").to_i,
          porcentagem_votos:    row["% Válidos"].gsub(/,/, ".").to_f,
          situacao_candidatura: row["Situação"]
        })
      end
    end

    def pega_csv_votos
      csv_votos = fetch_url(@url).body.encode("utf-8", "iso-8859-1")
      csv_votos = csv_votos.gsub!(/"";"";"";"";"";"";"";"[0-9]+(\.[0-9]+)?(\.[0-9]+)?";""\n/, '')

      CSV.parse(csv_votos, headers: true, col_sep: ';', quote_char: '"')
    end

    # candidatos nao encontrados automaticamente devido a divergencias de nomes das duas fontes de candidatos
    # TODO melhorar o metodo para idendificar candidados divegerntes
    def atualizar_deputados_estaticamente
      # nome, total_votos, porcentagem_votos, situacao_candidatura
      fixos = [
        ['BRUNIELE FERREIRA GOMES',                  45381,  0.45, 'Eleito por média' ],
        ['JOAO HENRIQUE HOLANDA  CALDAS',            135929, 9.82, 'Eleito por QP'    ],
        ['GIVALDO DE SÁ GOUVEIA',                    82582,  5.96, 'Eleito por QP'    ],
        ['ANTONIO PEDRO DE SIQUEIRA INDIO DA COSTA', 91523,  1.20, 'Eleito por QP'    ],
        ['ÁTILA SIDNEY LINS ALBUQUERQUE',            89453,  5.39, 'Eleito por média' ],
        ['JOAQUIM PASSARINHO PINTO DE SOUZA PORTO',  76148,  2.03, 'Eleito por QP'    ],
        ['JOVAIR DE OLIVEIRA ARANTES',               92945,  3.06, 'Eleito por QP'    ],
        ['JOÃO MARCELO SANTOS SOUZA',                83847,  2.68, 'Eleito por média' ]
      ]

      fixos.each do |attr|
        deputado = Deputado.find_by nome: attr[0]

        deputado.update_attributes({
          total_votos:          attr[1],
          porcentagem_votos:    attr[2],
          situacao_candidatura: attr[3]
        })
      end
    end

  end
end