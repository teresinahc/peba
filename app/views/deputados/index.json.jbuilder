json.total @deputados.total_entries

json.deputados @deputados do |deputado|
  json.partial! deputado
end
