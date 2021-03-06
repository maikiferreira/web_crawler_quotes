require 'nokogiri'
require 'open-uri'

class QuotesController < ApplicationController

  # Constante para armazenar o valor do token necessário para se ter acesso a API.
  TOKEN = "123456"
  URL = 'http://quotes.toscrape.com/'

  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :authenticate
  before_action :set_quote, only: [:index]

  # Inicia a pesquisa de frases com a tag passada como parametro na url.
  # Se a tag existir no documento de tags será feito uma pesquisa no documento
  # de Quote para obter as frases que possuem a tag pesquisada. Se a tag não
  # existir no documento de Tag será feito um crawler para obter as frases com
  # a tag passada como parâmetro
  def start
    result = searchTagBank(params[:quote])
    # Se a tag não for encontrada no banco será feito o crawler no site.
    if(result.length == 0)
      crawlerSite(params[:quote])
    end
    result = searchQuoteBank(params[:quote])
    render json: result
  end

  # Pesquisa no documento de Tag a tag passada como parâmetro.
  def searchTagBank(param)
    Tag.where(tag: param)
  end

  # Pesquisa no documento de Quote as quotes que possuem a tag passada como parâmetro.
  def searchQuoteBank(param)
    Quote.where(tags: { '$in': [param]})
  end

  # Adiciona uma Tag no documento de Tags se ela não estiver presente no documento.
  def addTag(param)
    if(Tag.where(tag: param).length == 0)
      Tag.create!(
        tag: param
      )
    end
  end

  # Adiciona uma Quote no documento de Quotes se ela não estiver presente no documento.
  def addQuote(quot, autho, author_abou, ta)
    frase = Quote.where(quote: quot)
      if (frase.length == 0)
        Quote.create!(
          quote: quot,
          author: autho,
          author_about: author_abou,
          tags: ta
        )
      end
  end

  # Obtém as tags de uma quote do conteudo do site onde estão presentes as tags
  # Retorna uma array onde cada posição é uma tag da quote.
  def obtainTagsQuote(tags, param)
    tag = []
    tags.search('a.tag').each do |a|
      tag.push(a.text)
      if(a.text == param)
        addTag(param)
      end
      next if a['class'] == 'tag'
    end
    tag
  end

  # Executa o crawler para obter as informações do site e armazenar no banco de dados.
  def crawlerSite(param)
    html = URI.open(URL)
    doc = Nokogiri::HTML(html)
    fields = doc.css('div.col-md-8')

    fields.search('div.quote').each do |div|
            quote = div.css('span.text').text
            author = div.css('small.author').text
            author_about = "http://quotes.toscrape.com/" + div.css('a')[0].attributes["href"].value  

            tag = obtainTagsQuote(div.css('div.tags'), param)
            
            if (tag.include?(param))
              addQuote(quote, author, author_about, tag)
            end
        next if div['class'] == 'tags'
    end
  end

  # Extrai o token da requisição e compara se é igual a constante TOKEN
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(TOKEN)
      )
    end
  end

end