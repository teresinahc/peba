=====
PEBA
=====

<a href="https://travis-ci.org/teresinahc/peba" target="_blank">
	<img src="https://travis-ci.org/teresinahc/peba.svg?branch=master" alt="Build Status">
</a>
<a href="https://codeclimate.com/github/teresinahc/peba" target="_blank">
	<img src="https://codeclimate.com/github/teresinahc/peba/badges/gpa.svg" alt="Code Climate">
</a>
<a href="https://codeclimate.com/github/teresinahc/peba" target="_blank">
	<img src="https://codeclimate.com/github/teresinahc/peba/badges/coverage.svg" alt="Test Coverage">
</a>

O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades governamentais com suporte para filtros e buscas avançadas.

---
Softwares utilizados
---

* Ruby on Rails
* Elasticsearch

---
Gems utilizadas
---

* nokogiri
* will_paginate
* bootstrap-sass
* rails-i18n
* sunspot_rails
* elasticsearch
* will_paginate-bootstrap
* chartkick

---
Como executar?
---

Primeiramente, no diretório `config`, crie uma cópia do arquivo `database.yml.template` com o nome `database.yml`. Abra este arquivo e modifique os valores de acordo com as configurações do seu banco de dados.

**Caso já possua ambiente ruby/rails instalado**

1. Instalar o Elasticsearch: https://www.elastic.co/

2. Instalar as dependências do projeto
    * `bundle install`

3. Executar os comandos para criar o banco e tabelas
    * `rake db:create db:migrate`

4. Iniciar o Elasticsearch.
    * elasticsearch

5. Rodar os scripts de crawler. (Segure firme. Vai demorar um pouco...)
    * `rake crawler:run`

6. Iniciar o rails
    * `rails s` ou `guard`


**Via Docker**

Antes de mais nada, tenha certeza de que tenha `docker` e `docker-compose` instalado.

1. Copie o arquivo de exemplo do `docker-compose`:

    cp docker-compose.yml.template docker-compose.yml

2. Copie os arquivos `config/database.yml.template` e `config/chewy.yml.template`, eles já estão prontos para serem usados com docker:

    cp config/database.yml.template config/database.yml
    cp config/chewy.yml.template config/chewy.yml

3. Levante o banco de dados (se você não tiver as imagens o primeiro comando pode demorar um pouco):

    docker-compose run app rake db:setup
    docker-compose run app rake crawler:run

4. Levante a app:

    docker-compose up app

Estes comandos só serão necessários caso seja a primeira vez que esteja rodando o sistema. Das próximas vezes, execute apenas o comando do passo **4**.


---
Como colaborar?
---
Você pode nos ajudar abrindo issues através do github reportando bugs e nos enviando sugestões. Aos que desejam colaborar com código, peço que enviem Pull Requests para o branch "develop".

Se desejar, pode seguir nosso <a href="https://trello.com/b/M1ldqi2V/peba" target="_blank">roadmap de desenvolvimento.</a>

---
Onde nos encontrar?
---
Disponibilizamos <a href="http://teresinahc.org/peba-feedback" target="_blank">um formulário</a> caso queira nos enviar alguma crítica ou sugestão.
Também estamos no: <a href="https://twitter.com/tocadopeba" target="_blank">@tocadopeba</a> siga o pebinha! =D
