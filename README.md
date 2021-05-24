# Web Crawler Quotes

O Web Crawler Quotes disponibiliza uma API que permite acesso aos dados das frases do site "http://quotes.toscrape.com/".

As dúvidas e solicitações relacionadas ao acesso da API, devem ser enviadas para o e-mail maikiferreira38@gmail.com.


## Tecnologias Utilizadas
- Ruby 3.0.0
- Rails 6.1.3.2
- MongoDB
- API (protegida por token)

## Solução Adotada

A solução do desafio foi feita utilizando o a linguagem de programação "ruby", o farmework "Ruby on Rails" e o "MongoDB" que é um banco de dados orientado a documentos. Para trabalhar com o "MongoDB" foi utilizado a gem "mongoid" que é uma estrutura ODM (Object-Document Mapper) para MongoDB em Ruby.

Foi criado um documento "Quote" para armazenar os dados obtidos através do crawler e o documento "Tag" para armazenar as tags que foram pesquisadas.

Com a criação da rota "/quote/{SEARCH_TAG}" foi possível obter a tag passada como parâmetro.

Obtendo a tag passada como parâmetro é verificado no documento "Tag" se ela está armazenada no banco de dados, se não estiver significa que a ela ainda não foi pesquisada e então será feito um crawler no site para obter os dados das frases que possuem determinada tag, apenas os dados das frases que ainda não foram cadastrados no banco de dados serão armazenadas.

Caso a tag passada como parâmetro já esteja presente no banco de dados significa que ela ja foi pesquisada anteriormente e os dados das frases com essa tag já estão presentes no banco de dados.

Após a verificação da tag, mesmo que não tenha sido pesquisada anteriormente, os dados das frases que a possuem vão estar cadastrados no banco de dados, com isto basta realizar uma consulta ao banco obtendo todas as frases que possuem a tag.

Com a obtenção dos dados das frases que possuem a tag passada como parâmetro foi feito uma serialização de objetos retornando um json formatado com os dados.

Para proteger as requisições ao endpoint "/quotes/{SEARCH_TAG}" foi criado uma constante "TOKEN" para armazenar o token de acesso, quando uma requisição for feita será obtido o seu token e comparado com o valor armazenado na constante e só será possível ter acesso aos dados as requisições que possuírem token igual ao da constante.

## Métodos

|Método | Descrição|
|--------|-----------|
|GET     |Retorna as informações de um ou mais registros.|

## Respostas

|Código | Descrição|
--------|----------
|200 | Requisição executada com sucesso (success).
|400 | Erros de validações ou os campos informados não existem no sistema.
|401 | Dados de acesso inválidos.

## Quotes

O endpoint /quotes/{SEARCH_TAG} permite o envio dos seguintes parâmetros:

|Parâmetro | Descrição
-----------|-----------
|search_tag       | Filtra os dados que possuem o valor informado.

## Autenticação

A API utiliza autenticação baseada em Token como forma de autenticação/autorização.

Para utilizar a API deve-se utilizar o token com valor igual a "123456". 

Utilizando o Postman para fazer uma requisição:

 - Em "Query Params" no campo "Key" será preenchido com "authorization" e em "Value" será preenchido com "Bearer Token 123456".

## Recursos

### /quotes/{SEARCH_TAG}

As quotes são os seus dados das frases que serão obtidas do site "http://quotes.toscrape.com/".

SEARCH_TAG é a tag que será utilizada como parâmetro de busca.

 - Request (aplication/json)
	 - Headers
		 - .../quotes/love
		 - authorization: Bearer Token [Token_Acesso]

- Response			
	-  Body
		
			[
			    {
			        "quote": "“It is better to be hated for what you are than to be loved for what you are not.”",
			        "author": "André Gide",
			        "author_about": "http://quotes.toscrape.com//author/Andre-Gide",
			        "tags": [
			            "life",
			            "love"
			        ]
			    }
			]
 
 ## Executando o Projeto Localmente

- No diretório devemos executar o seguinte comando para instalar as dependências especificadas no Gemfile.
	>  bundle install
	
- Iniciando o serviço do MongoDB 
	> systemctl start mongod

- Iniciando o servidor quem vem junto com o Ruby para acessar a aplicação por meio da web.
	> rails s

- Utilizando o Postman para realizar uma requisição.
	- A requisição deve ser do tipo "GET".
	- A URL deve ser no formato "http://localhost:3000/quotes/{SEARCH_TAG}"
	- A autenticação deve ser feita em "Query Params" onde no campo "Key" deve-ser preencher com "authorization" e em "Value" deverá ser preenchido com "Bearer Token 123456".
	- O retorno da requisição será um json contendo os dados das frases que possuem a "SEARCH_TAG" em suas tags. 
