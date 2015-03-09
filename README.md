=====
PEBA
=====
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

---
Como colaborar?
---
Você pode nos ajudar abrindo issues através do github reportando bugs e nos enviando sugestões. Aos que desejam colaborar com código, peço que enviem Pull Requests para o branch "develop".
