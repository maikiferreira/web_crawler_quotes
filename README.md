# README

## Objetivo
O objetivo deste software é a implementação de um software que irá buscar os dados no site "http://quotes.toscrape.com/" através de um web crawler.
A api possui o endpoint "/quotes/{SEARCH_TAG}" onde será disponibilizado os dados de acordo com a tag passada.

## Tecnologias Utilizadas
- Ruby 3.0.0
- Rails 6.1.3.2
- MongoDB
- API (protegida por token)

## Implementação
A solução do desafio foi feita criando o documento "Quote" para armazenar os dados obtidos através do crawler e o documento "Tag" para armazenar as tags que foram pesquisadas. 
Com a criação da rota "/quotes/{SEARCH_TAG}" foi possível obter a tag passada como parâmetro. 
Obtendo a tag passada como parâmetro é verificado no documento de tags se aquela tag está armazenada no banco de dados, se não estiver significa que a tag ainda não foi pesquisada e então será feito um crawler no site para obter os dados das frases que possuem a tag, apenas os dados das frases que ainda não foram cadastradas no banco de dados serão armazenadas e a pesquisada será armazenada no documento "Tag". Caso a tag passada como parâmetro já esteja presente no banco de dados significa que ela ja foi pesquisada anteriormente e os dados das frases com essa tag já estão presentes no banco de dados.
Após a verificação da tag, mesmo que não tenha sido pesquisada anteriormente, os dados das frases que a possuem vão estar cadastradas no banco de dados, com isto basta apenas realizar uma consulta ao banco obtendo todas as frases que possuem a tag.
Após obter os dados das frases que possuem a tag passada como parâmetro os dados serão formatados através de uma seralização de objetos e retornando um json.
Para proteger as requisições ao endpoint foi criado uma constante "TOKEN" para armazenar o token de acesso. Quando uma requisição for feita será obtido o seu token e comparado com o valor armazenado na constante "TOKEN", só será possível ter acesso aos dados as requisiçĩoes que possuirem o tokem igual o da constante.

##Funcionamento
- Primeiro devemos instalar as dependências utilizadas atraves do comando "bundle install".
- Logo depois precisamos iniciar o serviço do mongodb através do comando "systemctl start mongod".
- Em seguida devemos iniciar a execução da aplicação através do comando "rails s".
- Para realizar um teste iremos utilizar o Postman.
    - Iremos fazer uma requisição do tipo "Get" e utilizando autozização através de token. O token de acesso "secret123".
    - 

