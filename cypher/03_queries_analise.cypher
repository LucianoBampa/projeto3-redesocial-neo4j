// =====================================================
// USUÁRIOS MAIS INFLUENTES (MAIS SEGUIDOS)
// =====================================================
// Identifica usuários com maior número de seguidores

MATCH (u:User)<-[:FOLLOWS]-(:User)
RETURN
  u.user_id AS user_id,
  u.username AS usuario,
  count(*) AS seguidores
ORDER BY seguidores DESC
LIMIT 10;

// Insight de negócio:
// Usuários com mais seguidores são ideais para campanhas,
// parcerias e divulgação de conteúdo.


// =====================================================
// USUÁRIOS COM MAIOR ENGAJAMENTO
// =====================================================
// Soma de likes e retweets dos tweets publicados

MATCH (u:User)-[:POSTS]->(t:Tweet)
RETURN
  u.username AS usuario,
  sum(t.likes + t.retweets) AS engajamento_total
ORDER BY engajamento_total DESC
LIMIT 10;

// Insight:
// Nem sempre quem tem mais seguidores gera mais engajamento.


// =====================================================
// TWEETS MAIS POPULARES
// =====================================================
// Conteúdos com maior impacto na rede

MATCH (t:Tweet)
RETURN
  t.tweet_id AS tweet_id,
  t.text AS texto,
  (t.likes + t.retweets) AS popularidade
ORDER BY popularidade DESC
LIMIT 10;


// =====================================================
// HASHTAGS MAIS UTILIZADAS
// =====================================================
// Identificação de temas e comunidades mais relevantes

MATCH (:Tweet)-[:HAS_HASHTAG]->(h:Hashtag)
RETURN
  h.hashtags AS hashtag,
  count(*) AS uso
ORDER BY uso DESC
LIMIT 10;

// Insight:
// Hashtags indicam comunidades e interesses comuns.


// =====================================================
// REDE DE CONEXÕES ENTRE USUÁRIOS
// =====================================================
// Visualização simples de quem segue quem

MATCH (u:User)-[:FOLLOWS]->(f:User)
RETURN
  u.username AS usuario,
  f.username AS segue
LIMIT 20;


// =====================================================
// MENOR CAMINHO ENTRE DOIS USUÁRIOS
// =====================================================
// Mede proximidade social dentro da rede

MATCH p = shortestPath(
  (u1:User {user_id: 1})-[:FOLLOWS*]-(u2:User {user_id: 5})
)
RETURN p;


// =====================================================
// RECOMENDAÇÃO DE USUÁRIOS PARA SEGUIR
// =====================================================
// Baseada em amigos em comum (Friend of a Friend)

MATCH (u:User {user_id: 1})-[:FOLLOWS]->(:User)-[:FOLLOWS]->(recomendado:User)
WHERE NOT (u)-[:FOLLOWS]->(recomendado)
  AND u <> recomendado
RETURN
  recomendado.username AS recomendado,
  count(*) AS conexoes_em_comum
ORDER BY conexoes_em_comum DESC
LIMIT 5;

// Insight de negócio:
// Base para sistemas de recomendação personalizados.


// =====================================================
// USUÁRIOS COM INTERESSES SEMELHANTES
// =====================================================
// Usuários que compartilham hashtags em comum

MATCH (u1:User)-[:POSTS]->(:Tweet)-[:HAS_HASHTAG]->(h:Hashtag)
      <-[:HAS_HASHTAG]-(:Tweet)<-[:POSTS]-(u2:User)
WHERE u1 <> u2
RETURN
  u1.username AS usuario_1,
  u2.username AS usuario_2,
  h.hashtags AS hashtag_comum
LIMIT 20;


// =====================================================
// ANÁLISE DE PERFORMANCE - RECOMENDAÇÃO
// =====================================================
// Avaliação do plano de execução da query de recomendação

EXPLAIN
MATCH (u:User {user_id: 1})-[:FOLLOWS]->(:User)-[:FOLLOWS]->(r:User)
WHERE NOT (u)-[:FOLLOWS]->(r)
RETURN r;


// =====================================================
// PROFILE - MENOR CAMINHO
// =====================================================
// Avaliação detalhada de custo e gargalos

PROFILE
MATCH p = shortestPath(
  (u1:User {user_id: 1})-[:FOLLOWS*]-(u2:User {user_id: 5})
)
RETURN p;
