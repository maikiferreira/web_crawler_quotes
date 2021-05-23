class QuotesController < ApplicationController
  #before_action :set_quote, only: [:show, :update, :destroy]
  before_action :set_quote, only: [:index]
  
  def iniciar
    #render json: params[:quote]
    render json: pesquisarTagBanco(params[:quote])
  end
end

# Pesquisa no documento de Tag a tag passada como parâmetro.
def pesquisarTagBanco(param)
  Tag.where(tag: param)
end

# Pesquisa no documento de Quote as quotes que possuem a tag passada como parâmetro.
def pesquisarQuoteBanco(param)
  Quote.where(tags: { '$in': [param]})
end