module DespesasHelper

  def sum_partial_of_document_value(cost)
    cost.inject(0) { |sum, despesa| sum + despesa.valor_documento.to_f}
  end

end
