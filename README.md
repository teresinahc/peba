![PEBA](https://github.com/teresinahc/peba/raw/master/app/assets/images/peba_logo.png)

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
* Solr

---
Gems utilizadas
---

* nokogiri
* will_paginate
* bootstrap-sass
* rails-i18n
* sunspot_rails
* sunspot_solr
* will_paginate-bootstrap
* chartkick

---
Como executar?
---

Primeiramente, no diretório `config`, crie uma cópia do arquivo `database.yml.template` com o nome `database.yml`. Abra este arquivo e modifique os valores de acordo com as configurações do seu banco de dados.

**Caso já possua ambiente ruby/rails instalado**

1. Instalar o Apache Solr: https://cwiki.apache.org/confluence/display/solr/Installing+Solr

2. Instalar as dependências do projeto
    * `bundle install`

3. Executar os comandos para criar o banco e tabelas
    * `rake db:create db:migrate`

4. Iniciar o SOLR.
    * `bundle exec rake sunspot:solr:start`

5. Rodar os scripts de crawler. (Segure firme. Vai demorar um pouco...)
    * `rake crawler:run`

6. Iniciar o rails
    * `rails s` ou `guard`


**Via Docker**

Antes de mais nada, tenha certeza de que tenha `docker` e `docker-compose` instalado.

No item `default` do arquivo `config/database.yml`, modifique as seguintes linhas:

    password: rootpwd
    host: db
    port: 3306


Após, faça o seguinte para iniciar.

1. `docker-compose build`
2. `docker-compose up`
3. Em outra janela do terminal, execute o comando `make setup`

Estes comandos só serão necessários caso seja a primeira vez que esteja rodando o sistema. Das próximas vezes, execute apenas o comando do passo **2**.


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
