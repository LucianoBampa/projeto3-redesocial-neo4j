// =====================================================
// USUÁRIOS MAIS INFLUENTES (MAIS SEGUIDOS)
// =====================================================
MATCH (u:User)<-[:FOLLOWS]-()
RETURN u.user_id, u.username, count(*) AS seguidores
ORDER BY seguidores DESC
LIMIT 10;

## Insight de negócio
Usuários com mais seguidores são ideais para campanhas, parcerias e divulgação de conteúdo.

// =====================================================
// USUÁRIOS COM MAIOR ENGAJAMENTO
// =====================================================
MATCH (u:User)-[:POSTED]->(t:Tweet)
RETURN u.username,
       sum(t.likes + t.retweets) AS engajamento_total
ORDER BY engajamento_total DESC
LIMIT 10;

## Insight
Nem sempre quem tem mais seguidores gera mais engajamento.

// =====================================================
// TWEETS MAIS POPULARES
// =====================================================
MATCH (t:Tweet)
RETURN t.tweet_id,
       t.text,
       (t.likes + t.retweets) AS popularidade
ORDER BY popularidade DESC
LIMIT 10;

// =====================================================
// HASHTAGS MAIS UTILIZADAS
// =====================================================
MATCH (:Tweet)-[:HAS_HASHTAG]->(h:Hashtag)
RETURN h.name, count(*) AS uso
ORDER BY uso DESC
LIMIT 10;

## Insight
Hashtags indicam comunidades e interesses comuns.

// =====================================================
// REDE DE CONEXÕES ENTRE USUÁRIOS
// =====================================================
MATCH (u:User)-[:FOLLOWS]->(f:User)
RETURN u.username AS usuario, f.username AS segue
LIMIT 20;

// =====================================================
// MENOR CAMINHO ENTRE DOIS USUÁRIOS
// =====================================================
MATCH p = shortestPath(
  (u1:User {user_id: 1})-[:FOLLOWS*]-(u2:User {user_id: 5})
)
RETURN p;

// =====================================================
// RECOMENDAÇÃO DE USUÁRIOS PARA SEGUIR
// =====================================================
MATCH (u:User {user_id: 1})-[:FOLLOWS]->(:User)-[:FOLLOWS]->(recomendado:User)
WHERE NOT (u)-[:FOLLOWS]->(recomendado)
  AND u <> recomendado
RETURN recomendado.username, count(*) AS conexoes_em_comum
ORDER BY conexoes_em_comum DESC
LIMIT 5;

## Insight de negócio
Base para sistemas de recomendação personalizados.

// =====================================================
// USUÁRIOS COM INTERESSES SEMELHANTES
// =====================================================
MATCH (u1:User)-[:POSTED]->(:Tweet)-[:HAS_HASHTAG]->(h:Hashtag)<-[:HAS_HASHTAG]-(:Tweet)<-[:POSTED]-(u2:User)
WHERE u1 <> u2
RETURN u1.username, u2.username, h.name
LIMIT 20;

// =====================================================
// ANALISANDO PERFORMANCE DA RECOMENDAÇÃO
// =====================================================
EXPLAIN
MATCH (u:User {user_id: 1})-[:FOLLOWS]->(:User)-[:FOLLOWS]->(r:User)
WHERE NOT (u)-[:FOLLOWS]->(r)
RETURN r;

// =====================================================
// PROFILE DA QUERY DE MENOR CAMINHO
// =====================================================
PROFILE
MATCH p = shortestPath(
  (u1:User {user_id: 1})-[:FOLLOWS*]-(u2:User {user_id: 5})
)
RETURN p;





