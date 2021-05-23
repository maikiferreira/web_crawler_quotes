class QuotesController < ApplicationController
  #before_action :set_quote, only: [:show, :update, :destroy]
  before_action :set_quote, only: [:index]
  
  def showw
    render json: params[:quote]
  end
end
