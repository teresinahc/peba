class Deputados::DespesasController < ApplicationController
	def index
		@deputado = Deputado.com_total_despesas.find(params[:deputado_id])
		@despesas = @deputado.despesas.por_filtro(filter_params).paginate(page: params[:page], per_page: 20)
	end

  def filter_params
    filtro = Hash.new
    filtro[:num_ano]   = params[:num_ano]     unless params[:num_ano].blank?
    filtro[:num_mes]   = params[:num_mes]     unless params[:num_mes].blank?
    filtro[:descricao] = params[:descricao] unless params[:descricao].blank?
    
    return filtro
  end
end