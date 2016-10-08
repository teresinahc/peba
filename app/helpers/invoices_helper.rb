module InvoicesHelper

  def build_url(external_politic_id, year, external_document_id)
    link = "http://www.camara.leg.br/cota-parlamentar/documentos/publ/"
    link << external_politic_id.to_s + '/'
    link << year.to_s + '/'
    link << external_document_id.to_s + '.pdf'
  end

end
