@gastos.each do |ano|
  json.set! ano.keys.first.to_s do
    json.array! ano[ano.keys.first].values
  end
end
