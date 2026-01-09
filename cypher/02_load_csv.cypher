// =====================================================
// PROJETO: Análise de Rede Social com Neo4j
// ETAPA: Carga de Dados (LOAD CSV)
// FONTE: Dataset CSV hospedado no GitHub
// =====================================================


// =====================================================
// 1. LOAD USERS
// Criação dos nós de usuários
// =====================================================
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/LucianoBampa/projeto3-redesocial-neo4j/main/data/twitter_graph_dataset.csv"
AS row

MERGE (u:User {user_id: toInteger(row.user_id)})
SET u.username = row.username;


// =====================================================
// 2. LOAD TWEETS + RELAÇÃO POSTED
// Criação dos tweets e ligação com o autor
// =====================================================
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/LucianoBampa/projeto3-redesocial-neo4j/main/data/twitter_graph_dataset.csv"
AS row

MATCH (u:User {user_id: toInteger(row.user_id)})

MERGE (t:Tweet {tweet_id: toInteger(row.tweet_id)})
SET t.text = row.text,
    t.likes = toInteger(row.likes),
    t.retweets = toInteger(row.retweets)

MERGE (u)-[:POSTED]->(t);


// =====================================================
// 3. LOAD HASHTAGS
// Criação das hashtags e relacionamento com os tweets
// =====================================================
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/LucianoBampa/projeto3-redesocial-neo4j/main/data/twitter_graph_dataset.csv"
AS row

MATCH (t:Tweet {tweet_id: toInteger(row.tweet_id)})

UNWIND split(row.hashtags, ',') AS tag
MERGE (h:Hashtag {name: trim(tag)})

MERGE (t)-[:HAS_HASHTAG]->(h);


// =====================================================
// 4. LOAD FOLLOWS
// Criação das relações de seguimento entre usuários
// =====================================================
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/LucianoBampa/projeto3-redesocial-neo4j/main/data/twitter_graph_dataset.csv"
AS row

MATCH (u:User {user_id: toInteger(row.user_id)})

UNWIND split(row.follows, '|') AS follow_id
WITH u, follow_id
WHERE follow_id IS NOT NULL AND follow_id <> ""

MATCH (f:User {user_id: toInteger(follow_id)})

MERGE (u)-[:FOLLOWS]->(f);

