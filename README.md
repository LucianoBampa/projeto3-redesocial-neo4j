# projeto3-redesocial-neo4j
Projeto desenvolvido para o desafio de Grafos da DIO.

## Objetivo
Criar um protótipo funcional utilizando banco de dados em grafo (Neo4j)
capaz de gerar insights sobre engajamento, conexões entre usuários,
recomendações e comunidades de interesse em uma rede social.

## Tecnologias
- Neo4j Aura
- Cypher
- Dataset CSV
- Arrows (modelagem)
- GitHub

## Funcionalidades
- Identificação de usuários influentes
- Recomendação de conexões
- Menor distância entre usuários
- Análise de engajamento
- Comunidades baseadas em hashtags

## Carga de dados
“Os dados foram carregados a partir de um arquivo CSV hospedado no GitHub, utilizando LOAD CSV do Neo4j. A carga foi realizada de forma incremental, criando nós de usuários, tweets, hashtags e seus relacionamentos, garantindo integridade por meio de constraints e evitando duplicações com MERGE.”
“A carga foi dividida em etapas independentes para facilitar manutenção, leitura e análise de performance, permitindo uso de EXPLAIN e PROFILE em cada fase.”
