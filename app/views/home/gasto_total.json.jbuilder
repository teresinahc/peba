@gastos.each do |ano, valores|
  json.set! ano.to_s do
    json.array! valores.map! {|k,v| v.to_f }
  end
end
