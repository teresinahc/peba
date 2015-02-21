1. Executar os comandos para criar o banco e tabelas

```
   rake db:create db:migrate
```

2. Rodar os scripts de crawler.
```
	rake crawler:run
```

3. Iniciar o SOLR.
```
bundle exec rake sunspot:solr:start
```
