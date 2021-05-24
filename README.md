# Web Crawler Quotes

O Web Crawler Quotes disponibiliza uma API que permite acesso aos dados das frases do site "http://quotes.toscrape.com/".

As dúvidas e solicitações relacionadas ao acesso da API, devem ser enviadas para o e-mail maikiferreira38@gmail.com.


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

 - Utilize uma requisição do tipo "Get".
 - Monte a URL de requisição utilizando o seu endereço /quotes/{SEARCH_TAG}.
 - Em "Query Params" no campo "Key" será preenchido com "authorization" e em "Value" será preenchido com "Bearer Token 123456".
