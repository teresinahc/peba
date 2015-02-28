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

1. Executar os comandos para criar o banco e tabelas

```
rake db:create db:migrate
```
2. Iniciar o SOLR.
```
bundle exec rake sunspot:solr:start
```
3. Rodar os scripts de crawler.
```
rake crawler:run
```
4. Iniciar o rails
```
rails s
```
