=====
PEBA
=====
O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades governamentais com suporte para filtros e buscas avançadas.

---
Softwares utilizados
---

* Ruby on Rails
* Nokogiri
* Solr

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