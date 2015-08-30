json.array! @despesas.totais_por_descricao.each do |tipo|
  json.tipo          tipo[:descricao]
  json.total_liquido number_to_currency(tipo[:total_liquido])
  json.total         number_to_currency(tipo[:total])
end
