# projeto3-redesocial-neo4j
Projeto desenvolvido para o desafio de **Grafos da DIO**, utilizando banco de dados em grafo para análise de redes sociais.

## Objetivo
Criar um protótipo funcional utilizando **Neo4j** capaz de gerar insights sobre:
- Engajamento de usuários
- Conexões e relacionamentos
- Recomendações de usuários
- Comunidades de interesse

Demonstrando o uso de grafos para responder perguntas complexas que seriam custosas em bancos relacionais.

## Tecnologias Utilizadas
- Neo4j Aura
- Cypher Query Language
- Dataset CSV (Twitter-like)
- Arrows (modelagem do grafo)
- GitHub

## Funcionalidades Implementadas
- Identificação de usuários influentes
- Análise de engajamento (likes e retweets)
- Recomendação de novos usuários para seguir
- Cálculo da menor distância entre usuários
- Identificação de comunidades por hashtags
- Análise de performance com `EXPLAIN` e `PROFILE`

## Carga de Dados
Os dados foram carregados a partir de um arquivo CSV hospedado no GitHub, utilizando o comando `LOAD CSV` do Neo4j.

A carga foi realizada de forma incremental, criando:
- Nós de usuários
- Tweets
- Hashtags
- Relacionamentos entre usuários e conteúdos

Foram utilizadas **constraints** e o comando `MERGE` para garantir integridade dos dados e evitar duplicações.

A separação da carga em etapas independentes facilita a manutenção, leitura do código e análise de performance.

## Análises e Insights
O grafo permitiu responder perguntas complexas sobre:
- Influência e engajamento
- Proximidade entre usuários
- Recomendações personalizadas
- Formação de comunidades de interesse

O uso de algoritmos de caminho mínimo e análise de conexões evidencia o poder dos grafos para análise de redes sociais.

## Modelagem
A modelagem do grafo foi realizada com a ferramenta **Arrows**, representando usuários, tweets, hashtags e seus relacionamentos.
O modelo grafo-redesocial.png foi projetado para refletir diretamente os dados disponíveis no dataset,
priorizando simplicidade, performance e clareza analítica.

## Como Rodar
1. Clone o repositório
2. Abra Neo4j Aura
3. Configure a conexão
4. Execute os scripts em ordem:
   1. 01_constraints_and_indexes.cypher
   2. 02_load_csv.cypher
   3. 03_queries_analise.cypher
5. Veja os resultados executando as queries no Neo4j Browser

