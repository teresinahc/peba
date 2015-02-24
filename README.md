===== 
PEBA 
=====
O PEBA possui um mecanismo para obter os dados a partir dos WebServices de sites de dados públicos e indexa-los através do uso de softwares livres usando uma implementação denominada crawler.  Uma vez que estes dados são indexados eles se encontram disponĩveis para visualização e pesquisa a partir de uma aplicação web que pode ser acessado em qualquer navegador.

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
