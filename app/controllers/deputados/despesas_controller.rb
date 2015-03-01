class Deputados::DespesasController < ApplicationController
	layout 'search'

	def index
		@deputado = Deputado.com_total_despesas.find(params[:deputado_id])
		@despesas = @deputado.despesas
	end
end